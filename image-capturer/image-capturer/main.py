import os
import cv2
import logging
import requests
import sys
from datetime import datetime


logging.basicConfig(stream=sys.stdout, level=logging.INFO)

logger = logging.getLogger()
logger.setLevel(logging.INFO)

def capture_image(capture_device):

    current_timestamp = datetime.now().strftime("%m %d %Y, %H:%M,%S")

    __, frame = capture_device.read()

    cv2.waitKey(0)

    return frame


def upload_captured_frame(url, image):
    resp = requests.post(url, files = {"image": image})
    logger.info(f"Got response {resp}")

def main():
    backend_host = os.getenv("BACKEND_HOST")
    backend_url = f'http://{backend_host}'

    if backend_host is None:
        logger.error("Error retrieving BACKEND_HOST")
        return

    try:
        capture_device = cv2.VideoCapture(-0)
        image = capture_image(capture_device)
        upload_captured_frame(backend_url, image)
    except Exception as e:
        logger.error(e)
        raise
    finally:
        capture_device.release()


if __name__ == "__main__":
    main()
