#!/usr/bin/env sh

cvlc v4l2:///dev/video0:chroma=h264 --sout '#transcode{vcodec=mp2v,fps=30}:standard{access=http,mux=ts,mime=video/ts,dst=:8099}'
