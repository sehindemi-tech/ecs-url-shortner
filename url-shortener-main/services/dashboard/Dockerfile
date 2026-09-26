FROM golang:1.23-alpine AS builder

WORKDIR /build

RUN addgroup -g 1001 appgroup \
    && adduser -u 1001 -G appgroup -H -D appuser

COPY go.mod go.sum ./

RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-s -w" -o dashboard .


FROM scratch AS runtime

COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

COPY --from=builder /etc/passwd /etc/passwd

COPY --from=builder /build/dashboard /dashboard

USER appuser

EXPOSE 8081

ENTRYPOINT ["/dashboard"]
