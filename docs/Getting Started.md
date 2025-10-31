# Getting Started

## Prerequisites

**Required:**
- [Docker](https://docs.docker.com/get-docker/) - Container runtime
- [Go 1.25.3+](https://go.dev/doc/install) - For code generation
- [Make](https://www.gnu.org/software/make/) - Build automation (usually pre-installed on Linux/macOS)

**Optional (for frontend development):**
- [Node.js 25+](https://nodejs.org/) - For rapid frontend iteration

**New to these technologies?**
- [Docker Getting Started Guide](https://docs.docker.com/get-started/)
- [Makefile Tutorial](https://makefiletutorial.com/)
- [Go by Example](https://gobyexample.com/)
- [React Tutorial](https://react.dev/learn)

## Quick Start

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd <repository-name>
   ```

2. **Configure environment**
   ```bash
   cp .env.example .env
   ```
   Modify as needed for local development.

3. **Build and run**
   ```bash
   make build
   make run
   ```

4. **Access the application**
   - Open `http://localhost:8080` in a browser
   - API available at `http://localhost:8080/api/v1/*`

## Docker-First Development

This project uses Docker for all builds and deployments. The Dockerfile handles:
- Installing Go dependencies
- Building the frontend with Node/Vite
- Copying built frontend to `server/web/`
- Compiling the Go binary with embedded frontend
- Creating a minimal runtime image

## Common Commands

All commands are defined in the `Makefile`.

### Build
```bash
make build
```
Builds the Docker image tagged as `csh-home`. This runs the full build process: frontend compilation, Go code generation, and binary compilation with embedded assets.

### Run
```bash
make run
```
Runs the containerized application. Loads environment variables from `.env` file and exposes port 8080.

### Generate
```bash
make generate
```
Runs `go generate ./...` to regenerate `api/gen.go` from `api/openapi.yaml`. **Run this after modifying the OpenAPI specification.**

### Format
```bash
make fmt
```
Formats all Go code using `go fmt`. Run before committing changes.

### Lint
```bash
make lint
```
Runs `golangci-lint` for Go code and `npm run lint` for frontend code. Both run in Docker containers.

## Modifying the API

1. Edit `api/openapi.yaml` to add/change endpoints
2. Run `make generate` to regenerate Go code
3. Implement handler methods in `api/server_*.go`
4. Run `make build` to create a new Docker image
5. Run `make run` to test changes

## Rapid Frontend Development

For faster frontend iteration without rebuilding the Docker image:

1. **Start the backend container**
   ```bash
   make run
   ```

2. **In a new terminal, start the frontend dev server**
   ```bash
   cd web
   npm install
   npm run dev
   ```

The Vite dev server runs on `http://localhost:5173` (typically) with hot module reloading. All API requests (`/api/*`) are automatically proxied to the Docker container running the backend at `http://localhost:8080`. This allows rapid frontend changes without rebuilding the entire application.

When frontend work is complete, run `make build` to create a production Docker image with the embedded frontend.

## Useful Resources

- [OpenAPI Specification](https://swagger.io/specification/) - API spec format
- [Gin Framework Guide](https://gin-gonic.com/docs/) - HTTP framework documentation
- [oapi-codegen Documentation](https://github.com/oapi-codegen/oapi-codegen) - Code generator
- [Go embed Package](https://pkg.go.dev/embed) - File embedding
- [Docker Documentation](https://docs.docker.com/) - Container platform
- [Vite Guide](https://vitejs.dev/guide/) - Frontend build tool
