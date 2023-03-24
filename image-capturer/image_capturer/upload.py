import os
import requests
import numpy.typing as npt

from datetime import datetime


class MissingBackendHostExecption(Exception):
    pass


def make_backend_url() -> str:
    backend_host = os.environ.get('BACKEND_HOST')
    if backend_host is None:
        raise MissingBackendHostExecption()

    return f'http://{backend_host}'


"""
Uploads a captured image to the cloud storage
"""
def upload_captured_image(url: str, image: npt.ArrayLike):
    current_timestamp = datetime.now().strftime("%m %d %Y, %H:%M,%S")
    resp = requests.post(url, files = {f"{current_timestamp}": image})
    logger.info(f"Got response {resp}")
