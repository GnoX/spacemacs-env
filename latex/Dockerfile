FROM gnoxo/spacemacs-env:plain

COPY latex/.spacemacs "$UHOME/.spacemacs"

RUN apt-get update \
   && apt-get install -y texlive-base texlive-latex-extra latexmk python-pygments gnuplot dvipng \
   && apt-get autoremove -y \
   && rm -rf /tmp/* /var/lib/apt/lists/* /root/.cache/*

RUN apt-get update \
   && apt-get install automake imagemagick \
   && git clone https://github.com/politza/pdf-tools.git \
   && cd pdf-tools/server \
   && ./autobuild -i ${PWD} \
   && make -s install \
   && cd ../../ \
   && rm -rf pdf-tools /tmp/* /var/lib/apt/lists/* /root/.cache/*

RUN curl -L https://github.com/jgm/pandoc/releases/download/2.2/pandoc-2.2-1-amd64.deb -o pandoc.deb \
   && dpkg -i pandoc.deb \
   && apt-get install -f \
   && rm pandoc.deb \
   && apt-get autoremove -y \
   && rm -rf /tmp/* /var/lib/apt/lists/* /root/.cache/*

