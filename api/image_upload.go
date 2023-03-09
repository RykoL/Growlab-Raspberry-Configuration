package image_upload

import (
	"errors"
	"io"
	"log"
	"mime"
	"mime/multipart"
	"net/http"
)

func UploadImageHandler(w http.ResponseWriter, r *http.Request) {

	_, params, err := mime.ParseMediaType(r.Header.Get("Content-Type"))

	if err != nil {
		log.Println(r.Header.Get("Content-Type"))
		log.Println(err)
		w.WriteHeader(http.StatusInternalServerError)
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
		}
	}

	w.WriteHeader(http.StatusCreated)
}
