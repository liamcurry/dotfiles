---
description: 
globs: Dockerfile,*.dockerfile,.dockerignore,*.Dockerfile
alwaysApply: false
---
# Dockerfile Development Standards

Comprehensive rules for creating secure, efficient, and maintainable Docker images following industry best practices and Docker's official guidelines.

## When to Apply

Use this rule when:
- Writing or modifying Dockerfiles
- Optimizing container build performance
- Implementing multi-stage builds
- Working with Docker Compose configurations
- Implementing CI/CD with containerized applications

**Integrates with**: @12factor.mdc for cloud-native principles, @bash.mdc for shell scripts in containers, @grugbed.mdc for simplicity

## Core Principles Framework

### Build Optimization Classification
```
BUILD_TYPE := DEVELOPMENT | PRODUCTION | CI_CD
OPTIMIZATION_GOAL := SPEED | SIZE | SECURITY | RELIABILITY
COMPLEXITY := SIMPLE | MULTI_STAGE | MICRO_SERVICE
DEPLOYMENT_TARGET := LOCAL | CLOUD | EDGE | HYBRID
```

### Quality Decision Matrix
```
DOCKERFILE_SCORE = (
  SECURITY × 0.30 +          // Vulnerability resistance
  BUILD_EFFICIENCY × 0.25 +  // Cache utilization, build speed
  IMAGE_SIZE × 0.20 +        // Runtime efficiency, transfer speed
  MAINTAINABILITY × 0.15 +   // Long-term sustainability
  REPRODUCIBILITY × 0.10     // Consistent builds across environments
)
```

## Essential Dockerfile Patterns

### Minimal Base Template (Generic)
```dockerfile
# syntax=docker/dockerfile:1
FROM alpine:3.19

# Install security updates and essential tools
RUN apk update && apk upgrade && \
    apk add --no-cache \
        ca-certificates \
        dumb-init && \
    rm -rf /var/cache/apk/*

# Create non-root user
RUN addgroup -g 1001 -S appuser && \
    adduser -S appuser -u 1001

# Set working directory
WORKDIR /app

# Copy application files
COPY --chown=appuser:appuser . .

# Switch to non-root user
USER appuser

# Health check (customize for your application)
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost:${PORT:-8080}/health || exit 1

# Expose port
EXPOSE 8080

# Graceful shutdown signal
STOPSIGNAL SIGTERM

# Entry point
ENTRYPOINT ["dumb-init", "--"]
CMD ["./app"]
```

### Multi-Stage Build Pattern (Generic)
```dockerfile
# syntax=docker/dockerfile:1

# Stage 1: Build environment
FROM alpine:3.19 AS builder
RUN apk add --no-cache build-base
WORKDIR /src
COPY . .
RUN make build

# Stage 2: Production runtime
FROM alpine:3.19 AS runtime
RUN apk add --no-cache \
    ca-certificates \
    dumb-init && \
    addgroup -g 1001 -S appuser && \
    adduser -S appuser -u 1001

WORKDIR /app
COPY --from=builder --chown=appuser:appuser /src/dist/app ./app

USER appuser
EXPOSE 8080
ENTRYPOINT ["dumb-init", "--"]
CMD ["./app"]
```

## Build Optimization Strategies

### 1. Cache Layer Optimization
**Principle**: Order instructions from least to most frequently changing

```dockerfile
# ❌ Poor caching - invalidates on any file change
FROM alpine:3.19
COPY . .
RUN apk add --no-cache build-base && make build

# ✅ Optimal caching - dependencies cached separately
FROM alpine:3.19
RUN apk add --no-cache build-base
COPY Makefile requirements.txt ./
RUN make deps
COPY . .
RUN make build
```

### 2. Specific COPY Instructions
**Principle**: Copy only what's needed to minimize cache invalidation

```dockerfile
# ❌ Broad copy invalidates cache on any change
COPY . .

# ✅ Specific copy preserves cache for unrelated changes
COPY src/ ./src/
COPY static/ ./static/
COPY config/ ./config/
COPY Makefile requirements.txt ./
```

### 3. Combined RUN Instructions
**Principle**: Group related operations to minimize layers and cache package indices

```dockerfile
# ❌ Separate RUN instructions create unnecessary layers
RUN apk update
RUN apk add curl
RUN apk add wget
RUN rm -rf /var/cache/apk/*

# ✅ Combined operations in single cacheable unit
RUN apk update && \
    apk add --no-cache \
        curl \
        wget && \
    rm -rf /var/cache/apk/*
```

## Security Best Practices

### 1. Non-Root User Pattern
```dockerfile
# Alpine Linux
RUN addgroup -g 1001 -S appuser && \
    adduser -S appuser -u 1001
USER appuser

# Debian/Ubuntu
RUN groupadd -r appuser && useradd -r -g appuser appuser
USER appuser

# Using numeric IDs (more portable)
USER 1001:1001
```

### 2. Minimal Base Images
```dockerfile
# ✅ Minimal base images (ordered by size)
FROM scratch                    # Empty image - for static binaries only
FROM gcr.io/distroless/static   # No shell, package manager, or libc
FROM gcr.io/distroless/base     # Distroless with glibc
FROM alpine:3.19                # Minimal Linux with package manager
FROM debian:bookworm-slim       # Debian with minimal packages

# ❌ Avoid unless specifically needed
FROM ubuntu:latest             # Large, many unnecessary packages
FROM centos:latest             # Large enterprise distribution
```

### 3. Secret Management
```dockerfile
# ❌ Never embed secrets in images
ENV API_KEY=secret123
COPY .env .

# ✅ Use build-time secrets or runtime environment
RUN --mount=type=secret,id=api_key \
    API_KEY=$(cat /run/secrets/api_key) && \
    # Use API_KEY during build only
    
# ✅ Runtime secrets via environment variables
ENV API_KEY=""
```

### 4. Security Scanning Integration
```dockerfile
# Add security scanning labels for automation
LABEL org.opencontainers.image.source="https://github.com/org/repo"
LABEL org.opencontainers.image.description="Production app image"
LABEL security.scan="enabled"

# Use specific versions to enable vulnerability tracking
FROM alpine:3.19.1
```

## Language-Specific Patterns

### Go Applications
```dockerfile
# Multi-stage Go build
FROM golang:1.21-alpine AS builder
WORKDIR /src
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o app .

FROM scratch
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /src/app /app
EXPOSE 8080
CMD ["/app"]
```

### Python Applications
```dockerfile
FROM python:3.11-alpine AS builder
WORKDIR /app
COPY requirements.txt .
RUN pip install --user --no-cache-dir -r requirements.txt

FROM python:3.11-alpine
RUN addgroup -g 1001 -S appuser && adduser -S appuser -u 1001
WORKDIR /app
COPY --from=builder /root/.local /home/appuser/.local
COPY --chown=appuser:appuser . .
USER appuser
ENV PATH=/home/appuser/.local/bin:$PATH
CMD ["python", "app.py"]
```

### Rust Applications
```dockerfile
FROM rust:1.75-alpine AS builder
RUN apk add --no-cache musl-dev
WORKDIR /src
COPY Cargo.toml Cargo.lock ./
RUN mkdir src && echo "fn main() {}" > src/main.rs && cargo build --release
COPY src ./src
RUN touch src/main.rs && cargo build --release

FROM alpine:3.19
RUN addgroup -g 1001 -S appuser && adduser -S appuser -u 1001
COPY --from=builder --chown=appuser:appuser /src/target/release/app /usr/local/bin/app
USER appuser
CMD ["app"]
```

### Node.js Applications (when needed)
```dockerfile
FROM node:20-alpine AS dependencies
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production && npm cache clean --force

FROM node:20-alpine
RUN addgroup -g 1001 -S nodejs && adduser -S nodejs -u 1001
WORKDIR /app
COPY --from=dependencies --chown=nodejs:nodejs /app/node_modules ./node_modules
COPY --chown=nodejs:nodejs . .
USER nodejs
CMD ["node", "server.js"]
```

## Image Size Optimization

### 1. Package Management Best Practices
```dockerfile
# ✅ Alpine package management
RUN apk update && \
    apk add --no-cache \
        curl \
        ca-certificates && \
    rm -rf /var/cache/apk/*

# ✅ Debian/Ubuntu package management  
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        curl \
        ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# ✅ Single-layer cleanup
RUN apk add --no-cache --virtual .build-deps \
        build-base \
        cmake && \
    make build && \
    apk del .build-deps
```

### 2. Build Artifact Cleanup
```dockerfile
# ✅ Clean up build artifacts in same layer
RUN make build && \
    make clean && \
    rm -rf /tmp/* /var/tmp/* ~/.cache

# ✅ Multi-stage to eliminate build dependencies
FROM alpine:3.19 AS builder
RUN apk add --no-cache build-base
COPY . .
RUN make build

FROM alpine:3.19
COPY --from=builder /src/dist/app ./app
# Build tools not included in final image
```

### 3. Universal .dockerignore
```dockerignore
# Version control
.git
.gitignore
.gitattributes
.gitmodules

# Documentation
README.md
docs/
*.md
CHANGELOG*
LICENSE*

# Development files
.vscode/
.idea/
*.swp
*.swo
*~

# OS files
.DS_Store
Thumbs.db
desktop.ini

# Temporary files
tmp/
temp/
*.tmp
*.log

# Build artifacts
build/
dist/
out/
target/
bin/
obj/

# Environment files
.env*
!.env.example

# Dependency directories (language-specific)
node_modules/
vendor/
__pycache__/
*.pyc
.pytest_cache/
.coverage
.mypy_cache/

# Language-specific build files
Cargo.lock  # if not a library
go.sum     # sometimes
```

## Advanced Patterns

### 1. Universal Health Check Patterns
```dockerfile
# HTTP service health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost:${PORT:-8080}/health || exit 1

# Database health check
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD pg_isready -h localhost -p ${DB_PORT:-5432} || exit 1

# Custom executable health check
COPY healthcheck.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/healthcheck.sh
HEALTHCHECK --interval=30s --timeout=10s --retries=3 \
  CMD /usr/local/bin/healthcheck.sh

# Process-based health check
HEALTHCHECK --interval=30s --timeout=3s --retries=3 \
  CMD pgrep -f "myapp" || exit 1
```

### 2. Signal Handling and Graceful Shutdown
```dockerfile
# Install and use dumb-init (Alpine)
RUN apk add --no-cache dumb-init
ENTRYPOINT ["dumb-init", "--"]

# Install and use tini (Debian/Ubuntu)
RUN apt-get update && apt-get install -y tini && rm -rf /var/lib/apt/lists/*
ENTRYPOINT ["tini", "--"]

# Configure graceful shutdown
STOPSIGNAL SIGTERM
CMD ["./app"]
```

### 3. Build Arguments and Environment Variables
```dockerfile
# Build-time arguments with defaults
ARG BUILD_ENV=production
ARG BUILD_DATE
ARG VERSION
ARG TARGETOS
ARG TARGETARCH

# Convert to environment variables if needed
ENV BUILD_ENV=${BUILD_ENV}

# Runtime environment variables
ENV PORT=8080
ENV LOG_LEVEL=info
ENV WORKERS=4

# Metadata labels
LABEL org.opencontainers.image.created=${BUILD_DATE}
LABEL org.opencontainers.image.version=${VERSION}
LABEL org.opencontainers.image.title="My Application"
LABEL org.opencontainers.image.url="https://github.com/org/repo"
```

## Docker Compose Integration

### Generic Production-Ready Compose Pattern
```yaml
version: '3.8'

services:
  app:
    build:
      context: .
      dockerfile: Dockerfile
      args:
        - BUILD_ENV=production
        - BUILD_DATE=${BUILD_DATE:-$(date -u +'%Y-%m-%dT%H:%M:%SZ')}
        - VERSION=${VERSION:-latest}
    image: myapp:${VERSION:-latest}
    restart: unless-stopped
    environment:
      - ENV=production
      - PORT=8080
      - DATABASE_URL=${DATABASE_URL}
    ports:
      - "8080:8080"
    healthcheck:
      test: ["CMD", "wget", "--no-verbose", "--tries=1", "--spider", "http://localhost:8080/health"]
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 30s
    depends_on:
      database:
        condition: service_healthy
    networks:
      - app-network
    logging:
      driver: "json-file"
      options:
        max-size: "10m"
        max-file: "3"
    deploy:
      resources:
        limits:
          cpus: '1.0'
          memory: 512M
        reservations:
          cpus: '0.5'
          memory: 256M

  database:
    image: postgres:16-alpine
    restart: unless-stopped
    environment:
      - POSTGRES_DB=${POSTGRES_DB:-myapp}
      - POSTGRES_USER=${POSTGRES_USER:-postgres}
      - POSTGRES_PASSWORD=${POSTGRES_PASSWORD}
    volumes:
      - postgres_data:/var/lib/postgresql/data
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U ${POSTGRES_USER:-postgres} -d ${POSTGRES_DB:-myapp}"]
      interval: 10s
      timeout: 5s
      retries: 5
    networks:
      - app-network

volumes:
  postgres_data:

networks:
  app-network:
    driver: bridge
```

## Validation and Quality Gates

### Build Checks Integration
```bash
# Docker build with checks
docker build --check .

# Comprehensive validation pipeline
validate_dockerfile() {
  # Syntax validation
  docker build --check . || return 1
  
  # Security scanning
  docker scout cves . || return 1
  
  # Best practices linting
  hadolint Dockerfile || return 1
  
  # Size analysis
  docker images --format "table {{.Repository}}:{{.Tag}}\t{{.Size}}" | grep myapp
  
  # Layer analysis
  docker history myapp:latest --human --format "table {{.CreatedBy}}\t{{.Size}}"
}
```

### Common Anti-Patterns to Avoid

#### ❌ Security Anti-Patterns
```dockerfile
# Running as root
USER root

# Hardcoded secrets
ENV PASSWORD=mysecret

# Latest tags in production
FROM alpine:latest

# Unnecessary packages
RUN apk add --no-cache build-base python3 gcc

# World-writable directories
RUN chmod 777 /app
```

#### ❌ Performance Anti-Patterns
```dockerfile
# Cache-busting order
COPY . .
RUN make deps

# Multiple layers for related operations
RUN apk update
RUN apk add curl

# No cleanup
RUN apk add --no-cache build-base && \
    make build
# Missing: apk del build-base
```

#### ❌ Maintainability Anti-Patterns
```dockerfile
# No comments or documentation
FROM alpine:3.19
RUN apk add --no-cache some-package
COPY . .
EXPOSE 8080
CMD ["./app"]

# Magic numbers and hardcoded values
EXPOSE 3000
ENV MAX_CONNECTIONS=50
```

## Integration with Development Workflow

### CI/CD Pipeline Integration
```yaml
# GitHub Actions example
name: Docker Build and Deploy
on:
  push:
    branches: [main]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v3
        
      - name: Build and validate
        run: |
          docker build --check .
          docker build -t myapp:${{ github.sha }} .
          docker scout cves myapp:${{ github.sha }}
          
      - name: Push to registry
        if: github.ref == 'refs/heads/main'
        run: |
          docker tag myapp:${{ github.sha }} registry.example.com/myapp:latest
          docker push registry.example.com/myapp:latest
```

### Local Development Optimization
```dockerfile
# Development-specific Dockerfile
FROM alpine:3.19

# Install development tools
RUN apk add --no-cache \
    git \
    bash \
    make \
    curl

# Enable hot reloading (mount source as volume)
WORKDIR /app
VOLUME ["/app/src"]

# Development server
CMD ["make", "dev"]
```

## Performance Monitoring

### Build Time Analysis
```bash
# Build with timing
time docker build -t myapp .

# Analyze build context size
docker build --progress=plain . 2>&1 | grep "transferring context"

# Layer size analysis
docker history myapp --human --format "table {{.CreatedBy}}\t{{.Size}}"

# Build cache utilization
docker system df
docker builder du
```

### Runtime Performance
```dockerfile
# Add monitoring labels
LABEL monitoring.enabled="true"
LABEL metrics.port="9090"

# Resource limits in compose
services:
  app:
    deploy:
      resources:
        limits:
          cpus: '0.5'
          memory: 512M
        reservations:
          cpus: '0.25'
          memory: 256M
```

## References and Tools

### Essential Tools
- **hadolint**: Dockerfile linter for best practices
- **docker scout**: Security vulnerability scanning
- **dive**: Analyzing and optimizing image layers
- **trivy**: Comprehensive security scanner

### Validation Commands
```bash
# Comprehensive validation suite
dockerfile_validate() {
  echo "=== Dockerfile Validation ==="
  
  # 1. Syntax and best practices
  hadolint Dockerfile
  
  # 2. Build checks
  docker build --check .
  
  # 3. Security scan
  docker build -t temp-image .
  docker scout cves temp-image
  trivy image temp-image
  
  # 4. Size analysis
  docker images temp-image --format "table {{.Repository}}:{{.Tag}}\t{{.Size}}"
  
  # 5. Layer analysis
  dive temp-image
  
  # Cleanup
  docker rmi temp-image
}
```

## Quality Checklist

### Pre-Commit Validation
- [ ] **Security**: No hardcoded secrets, non-root user, minimal base image
- [ ] **Build Optimization**: Proper layer caching, specific COPY operations
- [ ] **Size Optimization**: Multi-stage builds, package cleanup, .dockerignore
- [ ] **Reliability**: Health checks, graceful shutdown, error handling
- [ ] **Documentation**: Comments explaining non-obvious decisions
- [ ] **Compliance**: Follows twelve-factor principles, reproducible builds

### Production Readiness
- [ ] **Monitoring**: Health checks, logging configuration, metrics labels
- [ ] **Security**: Vulnerability scanning passed, secrets externalized
- [ ] **Performance**: Build time optimized, image size minimized
- [ ] **Reliability**: Graceful shutdown, proper signal handling
- [ ] **Maintainability**: Clear documentation, consistent patterns

---

**Remember**: Container images are immutable infrastructure. Invest time in getting the Dockerfile right once rather than repeatedly patching production issues. Every optimization compounds across development velocity, deployment speed, and runtime efficiency.

**Cross-references:**
- @12factor.mdc for cloud-native application principles
- @bash.mdc for shell scripts used in containers  
- @grugbed.mdc for simplicity in container architecture
- @meta.mdc for decision-making frameworks
