#!/usr/bin/env python3

import cv2
import logging
import numpy as np
import numpy.typing as npt


logger = logging.getLogger(__name__)


"""
Calculates the mean of given pictures and compares it against a treshold
"""
def is_image_bright_enough(image: npt.ArrayLike, percentage_treshold: int = 20) -> bool:
    brightness_factor = (np.mean(image) * 100 / 255)
    logger.info(f"Brightness factor of image is {brightness_factor}")
    return brightness_factor > percentage_treshold


def capture_image(capture_device):

    __, frame = capture_device.read()
    cv2.waitKey(0)
    encoded_img = cv2.imencode(".png", frame)[1]

    return encoded_img
