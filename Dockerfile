FROM spacemacs/emacs25:develop

ENV UNAME="gnox"
ENV UID="1000"

RUN rm -rf /usr/share/emacs/25.3/lisp/org/*

COPY .spacemacs "$UHOME/.spacemacs"
COPY private "$UHOME/.emacs.d/private"

RUN install-deps
