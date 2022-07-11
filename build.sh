#!/bin/bash

#docker build . -t cptnalf/ubuntu-jetson:20.04

export DOCKER_BUILDKIT=1
docker build --progress=plain . -f Dockerfile -t cptnalf/ubuntu-l4t:focal-r32.7.1

docker build --progress=plain . -f Dockerfile.opencv -t cptnalf/ubuntu-l4t-opencv:4.5.0-r32.7.1
