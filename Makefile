GO := go

build:
	docker build . -t csh-home

fmt:
	$(GO) fmt ./...

lint:
	docker run -t --rm -v $(shell pwd):/app -w /app golangci/golangci-lint:v2.6.0 golangci-lint run

generate:
	$(GO) generate ./...

