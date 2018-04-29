#!/usr/bin/env bash

ALL_THE_ICONS_COMMIT="52d1f2d36468146c93aaf11399f581401a233306"

mkdir -p $UHOME/.local/share/fonts
curl -L "https://github.com/domtronn/all-the-icons.el/blob/${ALL_THE_ICONS_COMMIT}/fonts/{all-the-icons,file-icons,fontawesome,material-design-icons,octicons,weathericons}.ttf?raw=true" -o $UHOME/.local/share/fonts/#1.ttf
fc-cache -fv
