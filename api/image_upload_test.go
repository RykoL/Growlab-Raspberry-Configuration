package image_upload

import (
	"bytes"
	"mime/multipart"
	"net/http"
	"net/http/httptest"
	"testing"
)

const boundary = "whatever"

func makeRequest(recorder *httptest.ResponseRecorder) error {

	body := &bytes.Buffer{}

	writer := multipart.NewWriter(body)

	part, err := writer.CreateFormFile("image", "image.png")
	if err != nil {
		return err
	}

	part.Write([]byte{})
	contentType := writer.FormDataContentType()

	writer.Close()

	req := httptest.NewRequest("POST", "/", body)
	req.Header.Set("Content-Type", contentType)

	UploadImageHandler(recorder, req)

	return nil
}

func TestImageUploadReturnsStatusCreatedUponSuccess(t *testing.T) {
	rr := httptest.NewRecorder()

	makeRequest(rr)

	if rr.Result().StatusCode != http.StatusCreated {
		t.Errorf("Should return a 201 got %v", rr.Result().StatusCode)
	}
}

func TestImageUploadReturnsBadRequestIfNoImageIsAttachedToRequest(t *testing.T) {
	rr := httptest.NewRecorder()

	body := &bytes.Buffer{}

	writer := multipart.NewWriter(body)
	contentType := writer.FormDataContentType()

	writer.Close()

	req := httptest.NewRequest("POST", "/", body)
	req.Header.Set("Content-Type", contentType)

	UploadImageHandler(rr, req)

	if rr.Result().StatusCode != http.StatusBadRequest {
		t.Errorf("Should return a 400 got %v", rr.Result().StatusCode)
	}
}
