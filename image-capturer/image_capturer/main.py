import os
import cv2
import logging
import requests
import sys
from datetime import datetime


from upload import upload_captured_image, make_backend_url, MissingBackendHostExecption
from image import is_image_bright_enough, capture_image


logging.basicConfig(stream=sys.stdout, level=logging.INFO)

logger = logging.getLogger()
logger.setLevel(logging.INFO)


def main():
    capture_device = None
    try:
        backend_url = make_backend_url()

        capture_device = cv2.VideoCapture(-0)
        image = capture_image(capture_device)

        if is_image_bright_enough(image):
            upload_captured_image(backend_url, image)
        else:
            logger.warn('Image taken is not bright enough. Skip uploading.')

    except MissingBackendHostExecption:
        logger.error('Please supply the BACKEND_HOST environment variable.')
    except Exception as e:
        logger.error(e)
        raise
    finally:
        if capture_device is not None:
            capture_device.release()


if __name__ == '__main__':
    main()
