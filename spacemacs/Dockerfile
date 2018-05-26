FROM spacemacs/emacs25:develop

ENV UNAME="gnox"
ENV UID="1000"

COPY scripts/install_all_the_icons_fonts.sh $UHOME/install-fonts.sh

RUN apt-get update && apt-get install curl \
    && asEnvUser $UHOME/install-fonts.sh \
    && rm -rf /tmp/* /var/lib/apt/lists/* /root/.cache/* $UHOME/install-fonts.sh


RUN rm -rf /usr/share/emacs/25.3/lisp/org/*

COPY .spacemacs "$UHOME/.spacemacs"
COPY private "$UHOME/.emacs.d/private"

RUN install-deps
