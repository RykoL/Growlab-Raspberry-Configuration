package image_upload

import (
	"context"
	"errors"
	"io"
	"log"
	"mime"
	"mime/multipart"
	"net/http"
	"os"

	"cloud.google.com/go/storage"
	"github.com/GoogleCloudPlatform/functions-framework-go/functions"
)

type ImageHandler struct{}

func (h *ImageHandler) UploadImageToStorage(part *multipart.Part) error {
	ctx := context.Background()
	client, err := storage.NewClient(ctx)

	bucketName := os.Getenv("BUCKET_NAME")
	bucket := client.Bucket(bucketName)
	obj := bucket.Object(part.FileName())

	writer := obj.NewWriter(ctx)
	io.Copy(writer, part)

	writer.Close()
	return err
}

func (h *ImageHandler) HandleImageUpload(w http.ResponseWriter, r *http.Request) {
	log.Println("Called UploadImageHandler")
	_, params, err := mime.ParseMediaType(r.Header.Get("Content-Type"))

	if err != nil {
		log.Println("Unsupported media type supplied", r.Header.Get("Content-Type"))
		w.WriteHeader(http.StatusUnsupportedMediaType)
		return
	}

	reader := multipart.NewReader(r.Body, params["boundary"])
	part, err := reader.NextPart()

	if err != nil {
		if errors.Is(err, io.EOF) {
			w.WriteHeader(http.StatusBadRequest)
			return
		} else {
			log.Println(err)
			w.WriteHeader(http.StatusInternalServerError)
			return
		}
	}

	err = h.UploadImageToStorage(part)

	if err != nil {
		log.Println("Error encountered while uploading to bucket")
		log.Println(err)
		w.WriteHeader(http.StatusInternalServerError)
		return
	}

	log.Println("Finished execution")
	w.WriteHeader(http.StatusCreated)
}

func init() {
	h := ImageHandler{}
	functions.HTTP("UploadImageHandler", h.HandleImageUpload)
}
