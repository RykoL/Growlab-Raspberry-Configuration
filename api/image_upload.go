package image_upload

import (
	"errors"
	"io"
	"log"
	"mime"
	"mime/multipart"
	"net/http"

	"github.com/GoogleCloudPlatform/functions-framework-go/functions"
)

type ImageHandler struct{}

func (h *ImageHandler) UploadImageHandler(w http.ResponseWriter, r *http.Request) {
	log.Println("Called UploadImageHandler")
	_, params, err := mime.ParseMediaType(r.Header.Get("Content-Type"))

	if err != nil {
		log.Println("Unsupported media type supplied", r.Header.Get("Content-Type"))
		w.WriteHeader(http.StatusUnsupportedMediaType)
		return
	}

	reader := multipart.NewReader(r.Body, params["boundary"])
	_, err = reader.NextPart()

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

	log.Println("Finished execution")
	w.WriteHeader(http.StatusCreated)
}

func init() {
	h := ImageHandler{}
	functions.HTTP("UploadImageHandler", h.UploadImageHandler)
}
