import pytest
import os


from image_capturer.upload import make_backend_url, MissingBackendHostExecption


def test_make_backend_url_returns_proper_url_when_env_variable_is_set():

    os.environ["BACKEND_HOST"] = '127.0.0.1'

    assert make_backend_url() == 'http://127.0.0.1'


def test_make_backend_url_throws_exception_when_backend_host_is_not_set():

    del os.environ['BACKEND_HOST']
    with pytest.raises(MissingBackendHostExecption):
        make_backend_url()
