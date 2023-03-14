package main

import (
	"github.com/RykoL/growlab-raspberry-configuration/image_upload"
	"log"
	"net/http"
	"os"
)

func main() {
	handler := image_upload.ImageHandler{}
	http.HandleFunc("/", handler.UploadImageHandler)
	port := os.Getenv("PORT")

	if port == "" {
		port = "8080"
	}

	log.Printf("Listening on port %s", port)
	if err := http.ListenAndServe(":"+port, nil); err != nil {
		log.Fatal(err)
	}
}
