# syntax=docker/dockerfile:1

##
## Build frontend
## 
FROM docker.io/library/node:25-alpine AS npm-build
WORKDIR /npm-build
COPY web/ web/
RUN cd web/ && npm install && npm run build

##
## Build backend
## 
FROM docker.io/library/golang:1.25.3-alpine AS go-build
WORKDIR /go-build
COPY go.mod go.sum ./
RUN go mod download

COPY main.go ./

COPY api/ api/
COPY server/ server/
# Copy built frontend folder from frontend build stage
COPY --from=npm-build /npm-build/web/dist server/web

RUN CGO_ENABLED=0 GOOS=linux go build --ldflags '-extldflags "-static"' -o home .

##
## Build runnable container
##
FROM scratch
WORKDIR /app
# Copy built binary from backend build stage
COPY --from=go-build /go-build/home .
EXPOSE 8080
CMD ["/app/home"]
