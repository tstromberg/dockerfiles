#!/bin/sh
set -ux -o pipefail

xhost +local:docker
CONTAINER_NAME="firefox-ts"
IMAGE_NAME="tstromberg/firefox"


docker run --rm -it \
  --net host \
  --cpuset-cpus 2,4,6 \
  --memory 768mb \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v /dev/shm:/dev/shm \
  -v /run/dbus/:/run/dbus/ \
  -e DISPLAY=unix$DISPLAY \
  --device /dev/snd \
  --name "${CONTAINER_NAME}" \
  "${IMAGE_NAME}"
