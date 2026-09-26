"""
Database abstraction layer.

Supports two backends:
  - DynamoDB (default): set TABLE_NAME env var
  - PostgreSQL (RDS):   set DATABASE_URL env var (e.g. postgresql://user:pass@host:5432/dbname)

The backend is selected automatically based on which env var is set.
If both are set, DATABASE_URL takes precedence.
"""

import os
import logging

logger = logging.getLogger(__name__)

_backend = None
_redis = None

CACHE_TTL = int(os.environ.get("CACHE_TTL", 86400))


def _get_redis():
    global _redis
    if _redis is not None:
        return _redis

    redis_url = os.environ.get("REDIS_URL")
    if not redis_url:
        return None

    try:
        import redis as redis_lib
        client = redis_lib.from_url(redis_url, decode_responses=True)
        client.ping()
        _redis = client
        logger.info("Redis cache connected")
    except Exception as e:
        # Redis is a cache — failure must not break the service
        logger.warning(f"Redis unavailable, falling back to direct DB: {e}")
        _redis = None

    return _redis


def _cache_get(short_id: str):
    r = _get_redis()
    if not r:
        return None
    try:
        cached = r.get(f"url:{short_id}")
        if cached:
            return {"url": cached, "clicks": 0}
    except Exception as e:
        logger.warning(f"Redis get failed: {e}")
    return None


def _cache_set(short_id: str, url: str):
    r = _get_redis()
    if not r:
        return
    try:
        r.setex(f"url:{short_id}", CACHE_TTL, url)
    except Exception as e:
        logger.warning(f"Redis set failed: {e}")


def _get_backend():
    global _backend
    if _backend is not None:
        return _backend

    if os.environ.get("DATABASE_URL"):
        _backend = _init_postgres()
    elif os.environ.get("TABLE_NAME"):
        _backend = _init_dynamodb()
    else:
        raise RuntimeError("Set TABLE_NAME (DynamoDB) or DATABASE_URL (PostgreSQL)")

    return _backend


def _init_dynamodb():
    import boto3
    table = boto3.resource("dynamodb").Table(os.environ["TABLE_NAME"])

    def put(short_id: str, url: str):
        table.put_item(Item={"id": short_id, "url": url, "clicks": 0})
        _cache_set(short_id, url)

    def get(short_id: str):
        cached = _cache_get(short_id)
        if cached:
            return cached
        resp = table.get_item(Key={"id": short_id})
        item = resp.get("Item")
        if item:
            _cache_set(short_id, item["url"])
        return item

    def incr(short_id: str):
        table.update_item(
            Key={"id": short_id},
            UpdateExpression="SET clicks = if_not_exists(clicks, :zero) + :one",
            ExpressionAttributeValues={":one": 1, ":zero": 0},
        )

    return {"put": put, "get": get, "incr": incr, "type": "dynamodb"}


def _init_postgres():
    import psycopg2
    from psycopg2.extras import RealDictCursor

    conn = psycopg2.connect(os.environ["DATABASE_URL"])
    conn.autocommit = True

    with conn.cursor() as cur:
        cur.execute("""
            CREATE TABLE IF NOT EXISTS urls (
                id         TEXT PRIMARY KEY,
                url        TEXT NOT NULL,
                clicks     INTEGER NOT NULL DEFAULT 0,
                created_at TIMESTAMP DEFAULT NOW()
            )
        """)

    def put(short_id: str, url: str):
        with conn.cursor() as cur:
            cur.execute(
                "INSERT INTO urls (id, url) VALUES (%s, %s) ON CONFLICT (id) DO UPDATE SET url = %s",
                (short_id, url, url),
            )
        _cache_set(short_id, url)

    def get(short_id: str):
        cached = _cache_get(short_id)
        if cached:
            return cached
        with conn.cursor(cursor_factory=RealDictCursor) as cur:
            cur.execute("SELECT id, url, clicks FROM urls WHERE id = %s", (short_id,))
            item = cur.fetchone()
        if item:
            _cache_set(short_id, item["url"])
        return item

    def incr(short_id: str):
        with conn.cursor() as cur:
            cur.execute("UPDATE urls SET clicks = clicks + 1 WHERE id = %s", (short_id,))

    return {"put": put, "get": get, "incr": incr, "type": "postgres"}


def put_mapping(short_id: str, url: str):
    _get_backend()["put"](short_id, url)


def get_mapping(short_id: str):
    return _get_backend()["get"](short_id)


def increment_clicks(short_id: str):
    _get_backend()["incr"](short_id)


def get_backend_type() -> str:
    return _get_backend()["type"]
