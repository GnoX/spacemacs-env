#!/usr/bin/env bash

WORKSPACE=${HOME:-~}
NO_LATEX=false
USE_COMPOSE=false

while [[ $# -gt 0 ]]; do
    opt=$1
    case $opt in
        --no-latex)
            NO_LATEX='true'
            shift
            ;;
        -c|--use-compose)
            USE_COMPOSE=true
            shift
            ;;
        *)
            if [ -d $1 ]; then
                WORKSPACE=$1
            fi
            shift
            ;;
    esac
done

if [ "$NO_LATEX" = true ]; then
    SERVICE=spacemacs
    IMAGE=gnoxo/spacemacs-env:sp-dev
else
    SERVICE=spacemacs-latex
    IMAGE=gnoxo/spacemacs-env:sp-latex
fi

xhost +si:localuser:$(id -un)

if [ "$USE_COMPOSE" = true ]; then
    docker-compose pull $SERVICE && docker-compose up $SERVICE
else
    docker run -ti --name spacemacs \
           -e DISPLAY="unix$DISPLAY" \
           -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
           -v /etc/localtime:/etc/localtime:ro \
           -v /etc/machine-id:/etc/machine-id:ro \
           -v /var/run/dbus:/var/run/dbus \
           -v $WORKSPACE:/mnt/workspace \
           $IMAGE
fi
