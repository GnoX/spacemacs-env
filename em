#!/usr/bin/env bash

WORKSPACE=${HOME:-~}
IMAGE=$1

xhost +si:localuser:$(id -un)

docker run --name spacemacs \
    -e LC_ALL=en_US.UTF-8 \
        -e DISPLAY="unix$DISPLAY" \
        -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
        -v /etc/localtime:/etc/localtime:ro \
        -v /etc/machine-id:/etc/machine-id:ro \
        -v /var/run/dbus:/var/run/dbus \
        -v $WORKSPACE:/mnt/workspace \
        $IMAGE
