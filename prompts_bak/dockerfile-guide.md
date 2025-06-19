# Dockerfile Best Practices Guide

Essential guide for creating secure, efficient, and maintainable Docker
containers following industry standards and proven practices.

## Key Takeaways

1. **Security First**: Always run as non-root user, use minimal base images,
   never embed secrets
2. **Optimize Build Cache**: Order instructions from least to most frequently
   changing
3. **Multi-Stage Builds**: Separate build and runtime environments for smaller,
   cleaner images
4. **Strategic Layering**: Combine related operations in single RUN commands to
   reduce layers
5. **Pin Dependencies**: Use specific image tags and versions for reproducible
   builds

## Concepts

### Container Security Model

Docker containers share the host kernel, making security boundaries critical.
Running as root inside a container provides root-level access to host resources
through kernel interfaces. Minimal base images reduce attack surface by
eliminating unnecessary packages, shells, and system tools that attackers could
exploit.

### Build Cache Optimization

Docker caches each layer during builds using content-based hashing. When a layer
changes, all subsequent layers must be rebuilt, invalidating cached steps.
Strategic ordering preserves cache efficiency - place stable operations (package
installations) early, volatile operations (source code copies) late.

### Multi-Stage Build Pattern

Multi-stage builds use multiple FROM statements in one Dockerfile, creating
separate build environments. Build dependencies and tools remain in early
stages, while only necessary runtime artifacts copy to the final stage. This
approach typically reduces final image size by 70-90% while maintaining
security.

### Layer Management

Each Dockerfile instruction creates an immutable layer. Docker overlay
filesystem combines layers to create the final container image. Fewer layers
with combined operations perform better than many single-purpose layers due to
reduced filesystem overhead and faster image pulls.

## Rules

1. **Use specific base image tags** - `FROM alpine:3.19` not
   `FROM alpine:latest`
2. **Create non-root user** -
   `RUN adduser -D -s /bin/sh appuser && USER appuser`
3. **Set working directory explicitly** - `WORKDIR /app` prevents undefined
   behavior
4. **Copy dependencies first** - `COPY package.json .` before `COPY . .` for
   better caching
5. **Combine RUN operations** -
   `RUN apk add curl && apk add wget && rm -rf /var/cache/apk/*`
6. **Use .dockerignore** - Exclude unnecessary files from build context
7. **Implement health checks** -
   `HEALTHCHECK CMD curl -f http://localhost:8080/health`
8. **Use init process** - `RUN apk add dumb-init` and
   `ENTRYPOINT ["dumb-init", "--"]`
9. **Pin package versions** - Specify exact versions for reproducible builds
10. **Clean up in same layer** - Remove package caches and temporary files
    immediately

## Examples

### Good vs Bad Base Image Selection

**❌ Bad - Latest tag, large base image**

```dockerfile
FROM ubuntu:latest
RUN apt-get update && apt-get install -y python3
```

**✅ Good - Specific tag, minimal base**

```dockerfile
FROM python:3.11-alpine3.19
```

### Good vs Bad Caching Strategy

**❌ Bad - Invalidates cache on any file change**

```dockerfile
FROM node:18-alpine
COPY . .
RUN npm install
RUN npm run build
```

**✅ Good - Dependencies cached separately**

```dockerfile
FROM node:18-alpine
COPY package*.json ./
RUN npm ci --only=production
COPY . .
RUN npm run build
```

### Good vs Bad Multi-Stage Build

**❌ Bad - Single stage with build tools**

```dockerfile
FROM golang:1.21
COPY . .
RUN go build -o app .
CMD ["./app"]
# Final image: 800MB+ with Go compiler
```

**✅ Good - Multi-stage eliminates build tools**

```dockerfile
FROM golang:1.21 AS builder
COPY . .
RUN CGO_ENABLED=0 go build -o app .

FROM alpine:3.19
RUN adduser -D appuser
COPY --from=builder --chown=appuser:appuser /go/app /app
USER appuser
CMD ["/app"]
# Final image: 10MB without Go compiler
```

### Good vs Bad Layer Management

**❌ Bad - Multiple layers, no cleanup**

```dockerfile
FROM alpine:3.19
RUN apk update
RUN apk add curl
RUN apk add wget
RUN apk add ca-certificates
```

**✅ Good - Single layer with cleanup**

```dockerfile
FROM alpine:3.19
RUN apk update && \
    apk add --no-cache \
        curl \
        wget \
        ca-certificates && \
    rm -rf /var/cache/apk/*
```

### Good vs Bad Security Practices

**❌ Bad - Root user, hardcoded secrets**

```dockerfile
FROM alpine:3.19
ENV API_KEY=secret123
COPY . .
CMD ["./app"]
```

**✅ Good - Non-root user, external secrets**

```dockerfile
FROM alpine:3.19
RUN addgroup -g 1001 appuser && adduser -u 1001 -G appuser -D appuser
COPY --chown=appuser:appuser . .
USER appuser
CMD ["./app"]
# API_KEY provided at runtime via environment
```

## Resources

1. [Docker Official Best Practices](https://docs.docker.com/build/building/best-practices/) -
   Authoritative guide covering build optimization, security, and
   maintainability
2. [OWASP Docker Security Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Docker_Security_Cheat_Sheet.html) -
   Security-focused guidelines for container hardening
3. [Dockerfile Reference](https://docs.docker.com/reference/dockerfile/) -
   Complete syntax and instruction documentation
4. [Multi-stage Builds Documentation](https://docs.docker.com/build/building/multi-stage/) -
   Official guide for optimizing build processes
5. [Hadolint](https://github.com/hadolint/hadolint) - Dockerfile linter for best
   practices validation

## Checklist

- [ ] **Base image uses specific tag** (not latest)
- [ ] **Non-root user created and used** (USER directive)
- [ ] **Working directory set explicitly** (WORKDIR directive)
- [ ] **Dependencies copied before source code** (for caching)
- [ ] **RUN commands combined** (minimize layers)
- [ ] **.dockerignore file exists** (excludes unnecessary files)
- [ ] **Package caches cleaned** (in same RUN command)
- [ ] **Health check implemented** (HEALTHCHECK directive)
- [ ] **Init process used** (for signal handling)
- [ ] **No secrets in image** (use runtime environment variables)
- [ ] **Multi-stage build used** (when applicable)
- [ ] **Image scanned for vulnerabilities** (docker scout or trivy)
- [ ] **Build cache optimized** (stable operations first)
- [ ] **Resource limits considered** (for production deployment)
- [ ] **Graceful shutdown configured** (STOPSIGNAL SIGTERM)

