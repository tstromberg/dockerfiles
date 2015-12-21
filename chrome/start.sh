#!/bin/sh
set -ux -o pipefail

xhost +local:docker
CONTAINER_NAME="chrome-ts"
IMAGE_NAME="tstromberg/chrome"

docker inspect "${CONTAINER_NAME}"
if [[ $? -eq 0 ]]; then
  docker inspect "${CONTAINER_NAME}" | grep '"Running": true'
  if [[ $? -eq 0 ]]; then
    docker kill "${CONTAINER_NAME}"
  fi
  docker rm "${CONTAINER_NAME}"
fi

docker run -it \
  --net host \
  --cpuset-cpus 2,4,6 \
  --memory 2048mb \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v /dev/shm:/dev/shm \
  -v /run/dbus/:/run/dbus/ \
  -e DISPLAY=unix$DISPLAY \
  -v $HOME/Downloads:/root/Downloads \
  -v $HOME/.config/google-chrome/:/data \
  --device /dev/snd \
  --name "${CONTAINER_NAME}" \
  "${IMAGE_NAME}"
