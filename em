#!/usr/bin/env bash

WORKSPACE=${HOME:-~}
NO_LATEX=false

while [[ $# -gt 0 ]]; do
    opt=$1
    case $opt in
        --no-latex)
            NO_LATEX='true'
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
    IMAGE=gnoxo/spacemacs-env:plain
else
    SERVICE=spacemacs-latex
    IMAGE=gnoxo/spacemacs-env:latex
fi

xhost +si:localuser:$(id -un)

docker run --rm --name spacemacs \
    -e LC_ALL=en_US.UTF-8 \
        -e DISPLAY="unix$DISPLAY" \
        -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
        -v /etc/localtime:/etc/localtime:ro \
        -v /etc/machine-id:/etc/machine-id:ro \
        -v /var/run/dbus:/var/run/dbus \
        -v $WORKSPACE:/mnt/workspace \
        $IMAGE
