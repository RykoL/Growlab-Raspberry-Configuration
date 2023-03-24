import cv2
import os

from image_capturer.image import is_image_bright_enough


def test_image_is_bright_enough_returns_true_if_average_brightness_is_over_threshold():
    dark_image = cv2.imread("tests/data/dark_image.png")
    assert is_image_bright_enough(dark_image) == False


def test_image_is_bright_enough_returns_false_if_average_brightness_is_below_threshold():
    bright_image = cv2.imread("tests/data/bright_image.png")

    assert is_image_bright_enough(bright_image) == True
