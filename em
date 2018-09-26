#!/usr/bin/env bash

TAG=$1
NAME=${2:-spacemacs}
WORKSPACE=${3:-$HOME}

xhost +si:localuser:$(id -un)

docker run -d --name $NAME \
    -e LC_ALL=en_US.UTF-8 \
        -e DISPLAY="unix$DISPLAY" \
        -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
        -v /etc/localtime:/etc/localtime:ro \
        -v /etc/machine-id:/etc/machine-id:ro \
        -v /var/run/dbus:/var/run/dbus \
        -v $WORKSPACE:/mnt/workspace \
        gnoxo/spacemacs-env:$TAG
