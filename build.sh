#!/bin/bash
#docker build . -t autodump

docker buildx build --platform=linux/amd64 -t autodump .
