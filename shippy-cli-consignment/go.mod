module https://github.com/manoj-negi/golang-ecommerce/shippy-cli-consignment

go 1.14

// replace https://github.com/manoj-negi/golang-ecommerce/shippy-service-consignment => ../shippy-service-consignment

// replace https://github.com/manoj-negi/golang-ecommerce/shippy-service-vessel => ../shippy-service-vessel

replace google.golang.org/grpc => google.golang.org/grpc v1.26.0

require (
	github.com/golang/protobuf v1.4.2 // indirect
	github.com/micro/go-micro/v2 v2.8.1-0.20200603084508-7b379bf1f16e
	github.com/micro/protobuf v0.0.0-20180321161605-ebd3be6d4fdb // indirect
	google.golang.org/grpc v1.29.1
	google.golang.org/protobuf v1.24.0 // indirect
)
