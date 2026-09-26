from fastapi import FastAPI, HTTPException, Request
from fastapi.responses import RedirectResponse, FileResponse
from fastapi.staticfiles import StaticFiles
import os
import hashlib
import time
from .db import put_mapping, get_mapping, get_backend_type, increment_clicks
from .events import publish_click_event

app = FastAPI()


@app.get("/healthz")
def health():
    return {"status": "ok", "ts": int(time.time()), "db": get_backend_type()}


@app.post("/shorten")
async def shorten(req: Request):
    body = await req.json()
    url = body.get("url")
    if not url:
        raise HTTPException(400, "url required")
    short = hashlib.sha256(url.encode()).hexdigest()[:8]
    put_mapping(short, url)
    base_url = os.environ.get("BASE_URL", "")
    return {
        "short": short,
        "url": url,
        "short_url": f"{base_url}/{short}" if base_url else short,
    }


@app.get("/stats/{short_id}")
def stats(short_id: str):
    item = get_mapping(short_id)
    if not item:
        raise HTTPException(404, "not found")
    return {"short": short_id, "url": item["url"], "clicks": item.get("clicks", 0)}


@app.get("/dashboard")
def dashboard_page():
    # Explicit route for Vue dashboard page
    # Required because /{short_id} catch-all would otherwise intercept /dashboard
    index = os.path.join(os.environ.get("STATIC_DIR", "/app/static"), "index.html")
    if not os.path.isfile(index):
        raise HTTPException(404, "Frontend not built")
    return FileResponse(index)


@app.get("/{short_id}")
def resolve(short_id: str, request: Request):
    # Catch-all for short code redirects — must be last API route
    item = get_mapping(short_id)
    if not item:
        raise HTTPException(404, "not found")

    increment_clicks(short_id)

    publish_click_event(
        short_code=short_id,
        ip=request.client.host if request.client else "unknown",
        user_agent=request.headers.get("user-agent", ""),
        referer=request.headers.get("referer", ""),
    )

    return RedirectResponse(item["url"])


# Mount frontend last — after all API routes
# html=True serves index.html for root path and any unmatched static paths
_static_dir = os.environ.get("STATIC_DIR", "/app/static")
if os.path.isdir(_static_dir):
    app.mount("/", StaticFiles(directory=_static_dir, html=True), name="frontend")
