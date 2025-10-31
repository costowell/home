package api

// Generates the gin backend from the openapi.yaml
// This is here so that we can specify the version in go.mod and no binary install required
//go:generate go tool oapi-codegen -config ./oapi-codegen.yaml ./openapi.yaml

// Enforce APIServer implementing ServerInterface
// See https://go.dev/doc/faq#guarantee_satisfies_interface
var (
	_ ServerInterface = APIServer{}
)

// APIServer implements the oapi-codegen's ServerInterface
type APIServer struct{}

// NewAPIServer creates an APIServer
func NewAPIServer() APIServer {
	return APIServer{}
}
