# Repository Structure

## Tech Stack

**Backend:**
- [Go](https://go.dev/) - Programming language
- [Gin](https://gin-gonic.com/) - HTTP web framework
- [oapi-codegen](https://github.com/oapi-codegen/oapi-codegen) - OpenAPI code generator
- [zerolog](https://github.com/rs/zerolog) - Structured logging

**Frontend:**
- [React](https://react.dev/) - UI framework
- [TypeScript](https://www.typescriptlang.org/) - Type-safe JavaScript
- [Vite](https://vitejs.dev/) - Build tool and dev server

**Deployment:**
- [Docker](https://www.docker.com/) - Containerization

## Major Components

### api/
Contains the OpenAPI specification (`openapi.yaml`) and all API-related code. The generated code (`gen.go`) lives here along with the API implementation files (`server.go`, `server_*.go`).

### server/
Houses the HTTP server setup and embedded frontend. The `web/` subdirectory is populated during the Docker build with the compiled frontend.

### web/
React application source code built with Vite and TypeScript.

### main.go
Application entry point that initializes logging and starts the server.

### Makefile
Contains common development commands including `build`, `run`, `generate`, `fmt`, and `lint`. See the Development Workflow document for details on each command.

## Code Generation Flow

1. `api/openapi.yaml` defines the API specification
2. `api/server.go` contains `//go:generate go tool oapi-codegen -config ./oapi-codegen.yaml ./openapi.yaml`
3. Running `go generate ./...` triggers oapi-codegen
4. `api/gen.go` is generated with types, interfaces, and routing code
5. `api/server_*.go` files implement the generated interface methods

Adding a new endpoint: define it in `openapi.yaml`, run `make generate`, implement the handler method in a `server_*.go` file. The generated code automatically registers the route with Gin.

## Frontend Embedding

The compiled frontend lives in `server/web/` after the build process. The `//go:embed web` directive in `server/server.go` compiles the entire directory into the Go binary at build time. At runtime, `handleStatic()` serves these files from the embedded filesystem. Requests to paths starting with `/api` are handled by API routes; all other requests are served from the embedded files. If a requested file doesn't exist, `index.html` is served to enable client-side routing for the [Single Page Application (SPA)](https://developer.mozilla.org/en-US/docs/Glossary/SPA).
