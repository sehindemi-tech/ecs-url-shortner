
FROM node:lts-alpine AS frontend-builder

WORKDIR /frontend

COPY frontend/package*.json ./

RUN npm ci --ignore-scripts

COPY frontend/ .

RUN npm run build

FROM python:3.12-slim AS python-builder

WORKDIR /build

COPY requirements.txt .

RUN pip install --no-cache-dir --target /deps -r requirements.txt

FROM python:3.12-slim AS runtime

WORKDIR /app

RUN pip uninstall -y pip setuptools wheel 2>/dev/null || true

COPY --from=python-builder /deps /deps

COPY --from=frontend-builder /frontend/dist /app/static

COPY src/__init__.py src/main.py src/db.py src/events.py ./src/

ENV PYTHONPATH=/deps
ENV STATIC_DIR=/app/static
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

RUN addgroup --gid 1001 appgroup \
  && adduser --uid 1001 --gid 1001 --no-create-home --disabled-password appuser

USER appuser

EXPOSE 8080

CMD ["python", "-m", "uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "8080", "--workers", "1"]
