FROM spacemacs/emacs25:develop

RUN apt-get update \
   && apt-get install curl \
   && mkdir -p $UHOME/.local/share/fonts \
   && curl -L "https://github.com/domtronn/all-the-icons.el/blob/${ALL_THE_ICONS_COMMIT}/fonts/{all-the-icons,file-icons,fontawesome,material-design-icons,octicons,weathericons}.ttf?raw=true" -o $UHOME/.local/share/fonts\#1.ttf \
   && fc-cache -fv \
   && rm -rf /tmp/* /var/lib/apt/lists/* /root/.cache/* /usr/share/emacs/25.3/lisp/org/*

COPY plain/.spacemacs "$UHOME/.spacemacs"

COPY private "$UHOME/.emacs.d/private"

RUN install-deps

