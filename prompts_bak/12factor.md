# Twelve-Factor App Development Standards

Modern implementation of twelve-factor principles for cloud-native applications,
emphasizing developer productivity, operational excellence, and platform
portability.

## Core Principles Framework

### Factor Classification System

```text
FACTOR_TYPE := CODEBASE | DEPENDENCIES | CONFIG | BACKING_SERVICES | BUILD_RELEASE_RUN | PROCESSES | PORT_BINDING | CONCURRENCY | DISPOSABILITY | DEV_PROD_PARITY | LOGS | ADMIN_PROCESSES
SCOPE := APPLICATION | PLATFORM | DEPLOYMENT
IMPLEMENTATION := CONTAINER_NATIVE | KUBERNETES_READY | CLOUD_AGNOSTIC
```

## Implementation Guidelines

### I. Codebase - One Codebase, Multiple Deploys

**Pattern**: Single repository with environment-specific deployments

- **Structure**: Monorepo with clear service boundaries OR microrepo per service
- **Branching**: `main` for production, environment promotion via deployment
  configs
- **Deployment tracking**: Version tags, commit SHAs in deployment metadata

```dockerfile
# Dockerfile - Single build, multiple environments
FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production

FROM node:18-alpine
WORKDIR /app  
COPY --from=builder /app/node_modules ./node_modules
COPY . .
# Environment-specific config via runtime, not build-time
CMD ["npm", "start"]
```

### II. Dependencies - Explicitly Declare and Isolate

**Pattern**: Lock files + containerization + dependency scanning

- **Lock files**: Always commit `package-lock.json`, `Cargo.lock`, `poetry.lock`
- **Isolation**: Use containers, virtual environments, or language-specific
  isolation
- **Security**: Regular dependency scanning and updates

```yaml
# docker-compose.yml - Development parity
version: "3.8"
services:
  app:
    build: .
    volumes:
      - .:/app
      - node_modules:/app/node_modules
    environment:
      - NODE_ENV=development
```

### III. Config - Store Config in Environment

**Pattern**: Environment variables + secrets management + validation

- **Never commit**: API keys, passwords, database URLs
- **Validation**: Schema validation for all config at startup
- **Hierarchy**: Environment variables > config files > defaults

```javascript
// config/index.js - Validated configuration
const { z } = require("zod");

const configSchema = z.object({
  PORT: z.coerce.number().default(3000),
  DATABASE_URL: z.string().url(),
  JWT_SECRET: z.string().min(32),
  NODE_ENV: z.enum(["development", "staging", "production"]).default(
    "development",
  ),
  LOG_LEVEL: z.enum(["debug", "info", "warn", "error"]).default("info"),
});

module.exports = configSchema.parse(process.env);
```

### IV. Backing Services - Treat as Attached Resources

**Pattern**: Service discovery + connection pooling + circuit breakers

- **Abstraction**: Database, cache, message queues via environment config
- **Resilience**: Connection pooling, retries, circuit breakers
- **Local development**: Docker Compose for service dependencies

```yaml
# Local development backing services
services:
  postgres:
    image: postgres:15-alpine
    environment:
      POSTGRES_DB: myapp
      POSTGRES_USER: dev
      POSTGRES_PASSWORD: dev
    ports:
      - "5432:5432"

  redis:
    image: redis:7-alpine
    ports:
      - "6379:6379"
```

### V. Build, Release, Run - Strictly Separate Stages

**Pattern**: CI/CD pipeline with immutable artifacts

- **Build**: Create deployment artifact (container image, compiled binary)
- **Release**: Combine build with config for specific environment
- **Run**: Execute release in target environment

```yaml
# .github/workflows/deploy.yml
name: Build-Release-Run Pipeline
on:
  push:
    branches: [main]

jobs:
  build:
    runs-on: ubuntu-latest
    outputs:
      image-tag: ${{ steps.meta.outputs.tags }}
    steps:
      - uses: actions/checkout@v4
      - name: Build and push
        uses: docker/build-push-action@v5
        with:
          push: true
          tags: |
            ghcr.io/myorg/myapp:${{ github.sha }}
            ghcr.io/myorg/myapp:latest

  release:
    needs: build
    runs-on: ubuntu-latest
    steps:
      - name: Deploy to staging
        run: |
          helm upgrade --install myapp ./charts/myapp \
            --set image.tag=${{ github.sha }} \
            --set environment=staging
```

### VI. Processes - Execute as Stateless Processes

**Pattern**: Shared-nothing architecture + external state storage

- **Stateless**: No sticky sessions, no local file storage
- **State management**: Use Redis, database, or external storage for persistence
- **Process isolation**: Each process handles requests independently

```javascript
// Stateless request handler
app.get("/api/data", async (req, res) => {
  // Get state from external store, not local memory
  const sessionData = await redis.get(`session:${req.sessionId}`);
  const userData = await db.query("SELECT * FROM users WHERE id = ?", [
    req.userId,
  ]);

  res.json({ sessionData, userData });
});
```

### VII. Port Binding - Export Services via Port Binding

**Pattern**: Self-contained service + reverse proxy + service mesh

- **Self-contained**: App includes web server, not deployed into container
- **Port configuration**: Environment-driven port binding
- **Service discovery**: Health checks and service registration

```javascript
// Self-contained HTTP server
const express = require("express");
const config = require("./config");

const app = express();

// Health check endpoint
app.get("/health", (req, res) => {
  res.json({ status: "healthy", timestamp: new Date().toISOString() });
});

app.listen(config.PORT, "0.0.0.0", () => {
  console.log(`Server running on port ${config.PORT}`);
});
```

### VIII. Concurrency - Scale Out via Process Model

**Pattern**: Horizontal scaling + load balancing + async processing

- **Process types**: Web servers, background workers, schedulers
- **Scaling**: Independent scaling per process type
- **Load distribution**: Round-robin, least connections, or session affinity

```yaml
# Kubernetes deployment - Horizontal scaling
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-server
spec:
  replicas: 3
  selector:
    matchLabels:
      app: web-server
  template:
    spec:
      containers:
        - name: web
          image: myapp:latest
          env:
            - name: PROCESS_TYPE
              value: "web"
          resources:
            requests:
              memory: "128Mi"
              cpu: "100m"
            limits:
              memory: "256Mi"
              cpu: "200m"
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: worker
spec:
  replicas: 2
  selector:
    matchLabels:
      app: worker
  template:
    spec:
      containers:
        - name: worker
          image: myapp:latest
          env:
            - name: PROCESS_TYPE
              value: "worker"
```

### IX. Disposability - Fast Startup and Graceful Shutdown

**Pattern**: Signal handling + graceful shutdown + health checks

- **Fast startup**: Minimize boot time, lazy loading where appropriate
- **Graceful shutdown**: Handle SIGTERM for clean shutdown
- **Health checks**: Readiness and liveness probes

```javascript
// Graceful shutdown handler
const gracefulShutdown = (signal) => {
  console.log(`Received ${signal}. Starting graceful shutdown...`);

  server.close((err) => {
    if (err) {
      console.error("Error during server shutdown:", err);
      process.exit(1);
    }

    // Close database connections, finish pending tasks
    Promise.all([
      db.close(),
      redis.disconnect(),
      messageQueue.close(),
    ]).then(() => {
      console.log("Graceful shutdown completed");
      process.exit(0);
    }).catch((err) => {
      console.error("Error during graceful shutdown:", err);
      process.exit(1);
    });
  });
};

process.on("SIGTERM", () => gracefulShutdown("SIGTERM"));
process.on("SIGINT", () => gracefulShutdown("SIGINT"));
```

### X. Dev/Prod Parity - Keep Development and Production Similar

**Pattern**: Containerization + infrastructure as code + feature flags

- **Time gap**: Continuous deployment, short release cycles
- **Personnel gap**: Developers involved in deployment and monitoring
- **Tools gap**: Same backing services in dev and prod

```yaml
# docker-compose.override.yml - Development environment
version: "3.8"
services:
  app:
    volumes:
      - .:/app
      - /app/node_modules
    environment:
      - NODE_ENV=development
      - DATABASE_URL=postgresql://dev:dev@postgres:5432/myapp_dev
    command: npm run dev

  postgres:
    environment:
      POSTGRES_DB: myapp_dev
    volumes:
      - postgres_dev_data:/var/lib/postgresql/data
```

### XI. Logs - Treat Logs as Event Streams

**Pattern**: Structured logging + centralized collection + observability

- **Format**: JSON structured logs with correlation IDs
- **Output**: stdout/stderr only, no log files
- **Collection**: Log aggregation system (ELK, Fluentd, etc.)

```javascript
// Structured logging with correlation
const winston = require("winston");
const { v4: uuidv4 } = require("uuid");

const logger = winston.createLogger({
  format: winston.format.combine(
    winston.format.timestamp(),
    winston.format.json(),
  ),
  transports: [
    new winston.transports.Console(),
  ],
});

// Request correlation middleware
app.use((req, res, next) => {
  req.correlationId = req.headers["x-correlation-id"] || uuidv4();
  res.setHeader("X-Correlation-ID", req.correlationId);

  logger.info("Request started", {
    correlationId: req.correlationId,
    method: req.method,
    url: req.url,
    userAgent: req.headers["user-agent"],
  });

  next();
});
```

### XII. Admin Processes - Run Admin Tasks as One-off Processes

**Pattern**: CLI tools + database migrations + maintenance scripts

- **Environment**: Same environment as regular app processes
- **Execution**: One-time scripts, database migrations, data imports
- **Access**: Same codebase and dependencies as the app

```javascript
// CLI tool for admin tasks
#!/usr/bin/env node
const { Command } = require('commander');
const config = require('./config');
const db = require('./lib/database');

const program = new Command();

program
  .command('migrate')
  .description('Run database migrations')
  .action(async () => {
    console.log('Running migrations...');
    await db.migrate.latest();
    console.log('Migrations completed');
    process.exit(0);
  });

program
  .command('seed')
  .description('Seed database with initial data')
  .action(async () => {
    console.log('Seeding database...');
    await db.seed.run();
    console.log('Database seeded');
    process.exit(0);
  });

program.parse();
```

## Modern Cloud-Native Extensions

### XIII. Identity & Security (Proposed Factor)

**Pattern**: Zero-trust security + identity management + secrets rotation

- **Authentication**: OAuth2/OIDC integration
- **Authorization**: RBAC with principle of least privilege
- **Secrets**: External secret management (Vault, cloud KMS)

```yaml
# Kubernetes secret management
apiVersion: external-secrets.io/v1beta1
kind: SecretStore
metadata:
  name: vault-backend
spec:
  provider:
    vault:
      server: "https://vault.company.com"
      path: "secret"
      auth:
        kubernetes:
          mountPath: "kubernetes"
          role: "myapp"
```

### XIV. Observability & Telemetry

**Pattern**: OpenTelemetry + metrics + tracing + alerting

- **Metrics**: Application and business metrics
- **Tracing**: Distributed tracing across services
- **Alerting**: SLI/SLO-based monitoring

```javascript
// OpenTelemetry instrumentation
const { NodeSDK } = require("@opentelemetry/sdk-node");
const { getNodeAutoInstrumentations } = require(
  "@opentelemetry/auto-instrumentations-node",
);

const sdk = new NodeSDK({
  instrumentations: [getNodeAutoInstrumentations()],
  serviceName: "myapp",
  serviceVersion: process.env.APP_VERSION || "unknown",
});

sdk.start();
```

## Quality Gates & Validation

### Implementation Checklist

- [ ] **Codebase**: Single repo, version-controlled deployments
- [ ] **Dependencies**: Lock files committed, container isolation
- [ ] **Config**: Environment variables, secrets management
- [ ] **Backing Services**: Service discovery, connection pooling
- [ ] **Build/Release/Run**: CI/CD pipeline, immutable artifacts
- [ ] **Processes**: Stateless design, external state storage
- [ ] **Port Binding**: Self-contained service, health endpoints
- [ ] **Concurrency**: Horizontal scaling, process isolation
- [ ] **Disposability**: Graceful shutdown, fast startup
- [ ] **Dev/Prod Parity**: Same tools, containerized environments
- [ ] **Logs**: Structured logging, stdout/stderr only
- [ ] **Admin Processes**: CLI tools, migration scripts

### Validation Commands

```bash
# Verify twelve-factor compliance
docker build -t myapp .
docker run -e PORT=3000 myapp  # Port binding test
docker run myapp npm run migrate  # Admin process test
curl http://localhost:3000/health  # Health check test

# Security and dependency validation
npm audit --audit-level=moderate
docker scout cves
trivy image myapp:latest
```

## Common Anti-Patterns & Recovery

### Frequent Violations

- **Config in code**: Hardcoded URLs, API keys → Use environment variables
- **Sticky sessions**: Server-side session storage → Use Redis/external store
- **Local file storage**: Writing to container filesystem → Use object storage
- **Tight coupling**: Direct service calls → Use service discovery
- **Mixed environments**: Different tools dev vs prod → Containerize everything

### Migration Strategy

```markdown
## Twelve-Factor Migration Roadmap

1. **Assessment**: Audit current app against twelve factors
2. **Config extraction**: Move hardcoded config to environment variables
3. **State externalization**: Move session/cache to external services
4. **Containerization**: Create Dockerfile and docker-compose setup
5. **CI/CD pipeline**: Implement build-release-run separation
6. **Observability**: Add structured logging and health checks
7. **Validation**: Test dev/prod parity and disposability
```

## Framework Integration Examples

### Express.js Twelve-Factor Starter

```javascript
// app.js - Complete twelve-factor Express app
const express = require("express");
const helmet = require("helmet");
const cors = require("cors");
const config = require("./config");
const logger = require("./lib/logger");
const db = require("./lib/database");

const app = express();

// Security and middleware
app.use(helmet());
app.use(cors());
app.use(express.json());

// Health check (Factor VII - Port Binding)
app.get("/health", (req, res) => {
  res.json({
    status: "healthy",
    version: process.env.APP_VERSION || "unknown",
    timestamp: new Date().toISOString(),
  });
});

// Graceful shutdown (Factor IX - Disposability)
process.on("SIGTERM", gracefulShutdown);
process.on("SIGINT", gracefulShutdown);

module.exports = app;
```

### Docker Twelve-Factor Template

```dockerfile
# Multi-stage build (Factor V - Build/Release/Run)
FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production && npm cache clean --force

FROM node:18-alpine
# Non-root user for security
RUN addgroup -g 1001 -S nodejs && adduser -S nodejs -u 1001
WORKDIR /app

# Copy dependencies and app code
COPY --from=builder --chown=nodejs:nodejs /app/node_modules ./node_modules
COPY --chown=nodejs:nodejs . .

USER nodejs

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:${PORT:-3000}/health || exit 1

# Port binding (Factor VII)
EXPOSE 3000

# Graceful shutdown support (Factor IX)
STOPSIGNAL SIGTERM

CMD ["node", "server.js"]
```

## References & Further Reading

- [Original Twelve-Factor Methodology](mdc:https:/12factor.net)
- [Cloud Native Computing Foundation](mdc:https:/cncf.io)
- [OpenTelemetry Documentation](mdc:https:/opentelemetry.io)
- @docker-best-practices.mdc for container optimization
- @kubernetes-deployment.mdc for orchestration patterns
- @security-standards.mdc for identity and compliance requirements

---

**Remember**: Twelve-factor principles are guidelines, not rigid rules. Adapt
them to your specific use case while maintaining the core philosophy of build
portability, deployment simplicity, and operational excellence.
