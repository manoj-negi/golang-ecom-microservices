# 🛒 Ecommerce Microservices Platform

A production-ready ecommerce platform built with Go microservices using gRPC for inter-service communication.

## 📋 Table of Contents
- [Architecture Overview](#architecture-overview)
- [Services](#services)
- [Technology Stack](#technology-stack)
- [Project Structure](#project-structure)
- [Getting Started](#getting-started)
- [Development](#development)
- [Deployment](#deployment)
- [API Documentation](#api-documentation)
- [Monitoring](#monitoring)
- [Contributing](#contributing)

## 🏗️ Architecture Overview

This platform follows a microservices architecture pattern with the following principles:
- **Service Independence**: Each service can be developed, deployed, and scaled independently
- **Database per Service**: Each microservice owns its data
- **API Gateway**: Single entry point for all client requests
- **Event-Driven**: Asynchronous communication using message queues
- **Clean Architecture**: Clear separation of concerns with layered design

## 🎯 Services

| Service | Port | Description | Database |
|---------|------|-------------|----------|
| **API Gateway** | 8080 | Single entry point, request routing, authentication | Redis (cache) |
| **User Service** | 8081 | User management, authentication, profiles | PostgreSQL |
| **Product Service** | 8082 | Product catalog, categories, search | PostgreSQL |
| **Order Service** | 8083 | Order processing, order history | PostgreSQL |
| **Payment Service** | 8084 | Payment processing, refunds, billing | PostgreSQL |
| **Inventory Service** | 8085 | Stock management, reservations | PostgreSQL |
| **Notification Service** | 8086 | Email, SMS, push notifications | PostgreSQL |

## 🛠️ Technology Stack

- **Backend**: Go 1.21+
- **Communication**: gRPC with Protocol Buffers
- **Database**: PostgreSQL 15+
- **Cache**: Redis 7+
- **Message Queue**: RabbitMQ / Apache Kafka
- **API Gateway**: Custom Go gateway
- **Containerization**: Docker & Docker Compose
- **Orchestration**: Kubernetes
- **Monitoring**: Prometheus + Grafana
- **Tracing**: Jaeger
- **Documentation**: Buf for Proto management

## 📁 Project Structure

```
ecommerce-platform/
├── README.md
├── docker-compose.yml
├── Makefile
├── .env
├── deployments/
│   ├── kubernetes/
│   │   ├── namespace.yaml
│   │   ├── user-service.yaml
│   │   ├── product-service.yaml
│   │   ├── order-service.yaml
│   │   ├── payment-service.yaml
│   │   ├── inventory-service.yaml
│   │   ├── notification-service.yaml
│   │   └── api-gateway.yaml
│   └── docker/
│       └── Dockerfile.template
├── proto/
│   ├── buf.yaml
│   ├── buf.gen.yaml
│   ├── common/
│   │   ├── common.proto
│   │   └── pagination.proto
│   ├── user/
│   │   └── user.proto
│   ├── product/
│   │   └── product.proto
│   ├── order/
│   │   └── order.proto
│   ├── payment/
│   │   └── payment.proto
│   ├── inventory/
│   │   └── inventory.proto
│   └── notification/
│       └── notification.proto
├── pkg/
│   ├── pb/                    # Generated protobuf files
│   ├── middleware/
│   │   ├── auth.go
│   │   ├── logging.go
│   │   ├── recovery.go
│   │   └── metrics.go
│   ├── database/
│   │   ├── postgres.go
│   │   ├── redis.go
│   │   └── migrations/
│   ├── utils/
│   │   ├── validator.go
│   │   ├── jwt.go
│   │   ├── hash.go
│   │   └── response.go
│   └── config/
│       └── config.go
├── services/
│   ├── user-service/
│   │   ├── go.mod
│   │   ├── go.sum
│   │   ├── Dockerfile
│   │   ├── main.go
│   │   ├── internal/
│   │   │   ├── server/
│   │   │   │   └── server.go
│   │   │   ├── handler/
│   │   │   │   └── user_handler.go
│   │   │   ├── service/
│   │   │   │   └── user_service.go
│   │   │   ├── repository/
│   │   │   │   └── user_repository.go
│   │   │   └── models/
│   │   │       └── user.go
│   │   └── migrations/
│   │       └── 001_create_users_table.sql
│   ├── product-service/
│   │   ├── go.mod
│   │   ├── go.sum
│   │   ├── Dockerfile
│   │   ├── main.go
│   │   ├── internal/
│   │   │   ├── server/
│   │   │   │   └── server.go
│   │   │   ├── handler/
│   │   │   │   └── product_handler.go
│   │   │   ├── service/
│   │   │   │   └── product_service.go
│   │   │   ├── repository/
│   │   │   │   └── product_repository.go
│   │   │   └── models/
│   │   │       └── product.go
│   │   └── migrations/
│   │       └── 001_create_products_table.sql
│   ├── order-service/
│   │   ├── go.mod
│   │   ├── go.sum
│   │   ├── Dockerfile
│   │   ├── main.go
│   │   ├── internal/
│   │   │   ├── server/
│   │   │   │   └── server.go
│   │   │   ├── handler/
│   │   │   │   └── order_handler.go
│   │   │   ├── service/
│   │   │   │   └── order_service.go
│   │   │   ├── repository/
│   │   │   │   └── order_repository.go
│   │   │   ├── models/
│   │   │   │   └── order.go
│   │   │   └── clients/
│   │   │       ├── user_client.go
│   │   │       ├── product_client.go
│   │   │       ├── payment_client.go
│   │   │       └── inventory_client.go
│   │   └── migrations/
│   │       └── 001_create_orders_table.sql
│   ├── payment-service/
│   │   ├── go.mod
│   │   ├── go.sum
│   │   ├── Dockerfile
│   │   ├── main.go
│   │   ├── internal/
│   │   │   ├── server/
│   │   │   │   └── server.go
│   │   │   ├── handler/
│   │   │   │   └── payment_handler.go
│   │   │   ├── service/
│   │   │   │   └── payment_service.go
│   │   │   ├── repository/
│   │   │   │   └── payment_repository.go
│   │   │   ├── models/
│   │   │   │   └── payment.go
│   │   │   └── gateway/
│   │   │       ├── stripe.go
│   │   │       └── paypal.go
│   │   └── migrations/
│   │       └── 001_create_payments_table.sql
│   ├── inventory-service/
│   │   ├── go.mod
│   │   ├── go.sum
│   │   ├── Dockerfile
│   │   ├── main.go
│   │   ├── internal/
│   │   │   ├── server/
│   │   │   │   └── server.go
│   │   │   ├── handler/
│   │   │   │   └── inventory_handler.go
│   │   │   ├── service/
│   │   │   │   └── inventory_service.go
│   │   │   ├── repository/
│   │   │   │   └── inventory_repository.go
│   │   │   └── models/
│   │   │       └── inventory.go
│   │   └── migrations/
│   │       └── 001_create_inventory_table.sql
│   └── notification-service/
│       ├── go.mod
│       ├── go.sum
│       ├── Dockerfile
│       ├── main.go
│       ├── internal/
│       │   ├── server/
│       │   │   └── server.go
│       │   ├── handler/
│       │   │   └── notification_handler.go
│       │   ├── service/
│       │   │   └── notification_service.go
│       │   ├── repository/
│       │   │   └── notification_repository.go
│       │   ├── models/
│       │   │   └── notification.go
│       │   └── providers/
│       │       ├── email.go
│       │       ├── sms.go
│       │       └── push.go
│       └── templates/
│           ├── order_confirmation.html
│           └── payment_success.html
├── api-gateway/
│   ├── go.mod
│   ├── go.sum
│   ├── Dockerfile
│   ├── main.go
│   ├── internal/
│   │   ├── server/
│   │   │   └── server.go
│   │   ├── handler/
│   │   │   ├── user_handler.go
│   │   │   ├── product_handler.go
│   │   │   ├── order_handler.go
│   │   │   └── payment_handler.go
│   │   ├── middleware/
│   │   │   ├── auth.go
│   │   │   ├── cors.go
│   │   │   └── rate_limit.go
│   │   └── clients/
│   │       ├── user_client.go
│   │       ├── product_client.go
│   │       ├── order_client.go
│   │       ├── payment_client.go
│   │       ├── inventory_client.go
│   │       └── notification_client.go
│   └── docs/
│       └── swagger.yaml
├── web-ui/                    # Frontend (React/Vue/Angular)
│   ├── package.json
│   ├── src/
│   ├── public/
│   └── Dockerfile
├── monitoring/
│   ├── prometheus/
│   │   └── prometheus.yml
│   ├── grafana/
│   │   ├── dashboards/
│   │   └── datasources/
│   └── jaeger/
│       └── jaeger.yml
├── scripts/
│   ├── setup.sh
│   ├── build.sh
│   ├── deploy.sh
│   └── generate-proto.sh
└── docs/
    ├── API.md
    ├── DEPLOYMENT.md
    ├── DEVELOPMENT.md
    └── ARCHITECTURE.md
```

## Key Features of This Structure:

### 1. **Service Independence**
- Each service has its own `go.mod` for dependency management
- Independent deployments and scaling
- Database per service pattern

### 2. **Centralized Proto Definitions**
- All `.proto` files in one place
- Shared common types and pagination
- Consistent API contracts

### 3. **Clean Architecture**
- Handler → Service → Repository pattern
- Clear separation of concerns
- Easy testing and mocking

### 4. **Inter-Service Communication**
- gRPC clients for service-to-service calls
- API Gateway as single entry point
- Event-driven architecture ready

### 5. **DevOps Ready**
- Docker containers for each service
- Kubernetes deployment manifests
- Monitoring and observability setup

### 6. **Shared Packages**
- Common middleware, utilities, and configs
- Database connection helpers
- Authentication and validation

## Service Responsibilities:

- **User Service**: Authentication, user profiles, roles
- **Product Service**: Product catalog, categories, search
- **Order Service**: Order management, order history
- **Payment Service**: Payment processing, refunds
- **Inventory Service**: Stock management, reservations
- **Notification Service**: Email, SMS, push notifications
- **API Gateway**: Request routing, authentication, rate limiting

## Technology Stack:
- **Backend**: Go with gRPC
- **Database**: PostgreSQL per service
- **Cache**: Redis
- **Message Queue**: RabbitMQ/Apache Kafka
- **Monitoring**: Prometheus + Grafana
- **Tracing**: Jaeger
- **Gateway**: Custom Go gateway or Envoy Proxy
- **Container**: Docker + Kubernetes

## 🚀 Getting Started

### Prerequisites
- Go 1.21+
- Docker & Docker Compose
- PostgreSQL 15+
- Redis 7+
- Buf CLI (for proto generation)

### Quick Start

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-org/ecommerce-platform.git
   cd ecommerce-platform
   ```

2. **Generate Protocol Buffers**
   ```bash
   make proto-generate
   # or
   buf generate
   ```

3. **Start infrastructure services**
   ```bash
   docker-compose up -d postgres redis rabbitmq
   ```

4. **Run database migrations**
   ```bash
   make migrate-up
   ```

5. **Start all services**
   ```bash
   make run-all
   # or individually
   make run-user-service
   make run-product-service
   # etc...
   ```

6. **Start API Gateway**
   ```bash
   cd api-gateway
   go run main.go
   ```

The API Gateway will be available at `http://localhost:8080`

## 💻 Development

### Environment Setup

1. **Install dependencies**
   ```bash
   go mod download
   ```

2. **Set up environment variables**
   ```bash
   cp .env.example .env
   # Edit .env with your configuration
   ```

3. **Generate proto files**
   ```bash
   buf generate
   ```

### Running Services Locally

Each service can be run independently:

```bash
# User Service
cd services/user-service
go run main.go

# Product Service
cd services/product-service
go run main.go

# Order Service
cd services/order-service
go run main.go
```

### Database Migrations

```bash
# Run migrations for all services
make migrate-up

# Run migrations for specific service
make migrate-up-user
make migrate-up-product

# Rollback migrations
make migrate-down
```

### Testing

```bash
# Run all tests
make test

# Run tests for specific service
cd services/user-service
go test ./...

# Run integration tests
make test-integration
```

## 🚢 Deployment

### Docker Deployment

1. **Build all services**
   ```bash
   make docker-build
   ```

2. **Deploy with Docker Compose**
   ```bash
   docker-compose up -d
   ```

### Kubernetes Deployment

1. **Create namespace**
   ```bash
   kubectl apply -f deployments/kubernetes/namespace.yaml
   ```

2. **Deploy services**
   ```bash
   kubectl apply -f deployments/kubernetes/
   ```

3. **Check deployment status**
   ```bash
   kubectl get pods -n ecommerce
   ```

### Production Deployment

For production deployment, see [DEPLOYMENT.md](docs/DEPLOYMENT.md)

## 📚 API Documentation

### REST API Endpoints

The API Gateway exposes REST endpoints that internally communicate with gRPC services:

#### Authentication
- `POST /api/v1/auth/register` - User registration
- `POST /api/v1/auth/login` - User login
- `POST /api/v1/auth/refresh` - Refresh token

#### Users
- `GET /api/v1/users/profile` - Get user profile
- `PUT /api/v1/users/profile` - Update user profile

#### Products
- `GET /api/v1/products` - List products
- `GET /api/v1/products/{id}` - Get product details
- `POST /api/v1/products` - Create product (admin)

#### Orders
- `POST /api/v1/orders` - Create order
- `GET /api/v1/orders` - List user orders
- `GET /api/v1/orders/{id}` - Get order details

For complete API documentation, see [API.md](docs/API.md)

### gRPC Services

Each service exposes gRPC endpoints. Proto definitions are in the `/proto` directory.

## 📊 Monitoring

### Prometheus Metrics
- Service health and performance metrics
- Business metrics (orders, revenue, etc.)
- Infrastructure metrics

### Grafana Dashboards
- Service overview dashboard
- Business metrics dashboard
- Infrastructure monitoring

### Jaeger Tracing
- Distributed request tracing
- Performance bottleneck identification
- Service dependency mapping

Access monitoring tools:
- Grafana: `http://localhost:3000`
- Prometheus: `http://localhost:9090`
- Jaeger: `http://localhost:16686`

## 🧪 Testing Strategy

### Unit Tests
- Each service has comprehensive unit tests
- Mocked dependencies for isolation
- Coverage target: 80%+

### Integration Tests
- End-to-end API testing
- Database integration tests
- Inter-service communication tests

### Load Testing
- Performance testing with K6
- Stress testing scenarios
- Scalability validation

## 🔧 Available Make Commands

```bash
make help                 # Show available commands
make proto-generate       # Generate protobuf files
make build               # Build all services
make test                # Run all tests
make docker-build        # Build Docker images
make docker-push         # Push images to registry
make deploy-dev          # Deploy to development
make deploy-prod         # Deploy to production
make migrate-up          # Run database migrations
make migrate-down        # Rollback migrations
make clean               # Clean build artifacts
```

## 🏭 Production Considerations

### Security
- JWT-based authentication
- Rate limiting
- Input validation
- SQL injection prevention
- CORS configuration

### Performance
- Connection pooling
- Redis caching
- Database indexing
- Load balancing
- Horizontal scaling

### Reliability
- Circuit breakers
- Retry mechanisms
- Health checks
- Graceful shutdowns
- Data backup strategies

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

See [CONTRIBUTING.md](CONTRIBUTING.md) for detailed guidelines.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆘 Support

- Documentation: [docs/](docs/)
- Issues: [GitHub Issues](https://github.com/your-org/ecommerce-platform/issues)
- Discussions: [GitHub Discussions](https://github.com/your-org/ecommerce-platform/discussions)

## 🗺️ Roadmap

- [ ] Add GraphQL support
- [ ] Implement event sourcing
- [ ] Add machine learning recommendations
- [ ] Mobile app support
- [ ] Multi-tenant architecture
- [ ] Advanced analytics dashboard

---

**Built with ❤️ using Go and gRPC**
