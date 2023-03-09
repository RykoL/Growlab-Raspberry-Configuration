GO_SRC=$(find . -name "*.go")

start: clean image-upload-api
	./image-uploader

image-upload-api: $(GO_SRC)
	go build -o image-uploader ./cmd

clean:
	rm image-upload-api || true


test:
	go test -v

.PHONY=start clean test
