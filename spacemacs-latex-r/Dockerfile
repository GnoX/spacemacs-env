FROM gnoxo/spacemacs-env:latex

COPY spacemacs-latex-r/install-packages.r $UHOME/install-packages.r

RUN apt-get update && apt-get install -y \
    r-base \
    && apt-get autoremove -y \
    && rm -rf /tmp/* /var/lib/apt/lists/* /root/.cache/* \
    && curl https://codeload.github.com/emacs-ess/ESS/tar.gz/v17.11 --output ess.tar.gz \
    && mkdir $UHOME/.emacs.d/private/local/ESS \
    && tar xvf ess.tar.gz -C $UHOME/.emacs.d/private/local/ESS --strip-components=1\
    && rm ess.tar.gz

RUN echo "r <- getOption('repos'); r['CRAN'] <- 'http://cran.us.r-project.org'; options(repos = r);" > ~/.Rprofile \
    && Rscript $UHOME/install-packages.r \
    && rm $UHOME/install-packages.r
