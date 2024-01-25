#!/bin/bash
#docker build . -t autodump

docker build --platform=linux/amd64 -t autodump .
#docker buildx build --platform=linux/amd64 -t autodump .
