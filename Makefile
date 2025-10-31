GO := go

build:
	docker build . -t csh-home

run:
	docker run --env-file .env -p 8080:8080 -it csh-home:latest

fmt:
	$(GO) fmt ./...

lint:
	docker run -it --rm -v $(shell pwd):/app -w /app docker.io/golangci/golangci-lint:v2.6.0 golangci-lint run
	docker run -it --rm -v $(shell pwd)/web:/app -w /app docker.io/library/node:25-alpine npm run lint

generate:
	$(GO) generate ./...
