FROM spacemacs/emacs25:develop

COPY scripts/install_all_the_icons_fonts.sh $UHOME/install-fonts.sh

RUN apt-get update \
   && apt-get install curl \
   && asEnvUser $UHOME/install-fonts.sh \
   && rm -rf /tmp/* /var/lib/apt/lists/* /root/.cache/* /usr/share/emacs/25.3/lisp/org/*

COPY plain/.spacemacs "$UHOME/.spacemacs"

COPY private "$UHOME/.emacs.d/private"

RUN install-deps

RUN cd $UHOME/.emacs.d/elpa/develop/all-the-icons-2*/ \
   && rm all-the-icons.el all-the-icons.elc \
   && curl https://raw.githubusercontent.com/ubolonton/all-the-icons.el/f85f6ca9bc8d84044a700e137aecacfbdf87603f/all-the-icons.el -o all-the-icons.el

