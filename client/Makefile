BINARY_NAME=client

build:
	mkdir build
	go build --ldflags '-linkmode external -extldflags "-static"' -o build/${BINARY_NAME} main.go

run:
	mkdir build
	go build --ldflags '-linkmode external -extldflags "-static"' -o build/${BINARY_NAME} main.go
	go run ${BINARY_NAME}

clean:
	go clean
	rm -Rf build

all: build
