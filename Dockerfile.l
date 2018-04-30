FROM gnoxo/spacemacs

RUN apt-get update && apt-get install -y \
      texlive-base \
      texlive-latex-extra \
      latexmk \
      python-pygments \
      gnuplot

RUN apt-get install automake \
    && git clone https://github.com/politza/pdf-tools.git \
    && cd pdf-tools/server \
    && ./autobuild -i ${PWD} \
    && make -s install \
    && cd ../../ \
    && rm -rf pdf-tools \
    && rm -rf /tmp/* /var/lib/apt/lists/* /root/.cache/*
