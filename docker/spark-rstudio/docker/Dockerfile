FROM vogt1005.scripps.edu:5000/spark

RUN apt-get update \ 
    && apt-get install -y --no-install-recommends \
        ed \
        less \
        locales \
        vim-tiny \
        wget \
        ca-certificates \
        libxml2-dev \
        libssl-dev \
        libcurl4-openssl-dev \
        openjdk-8-jdk \
        fonts-liberation \
    && mkdir -p /usr/share/fonts/truetype/google_fonts \
    && cd /usr/share/fonts/truetype/google_fonts \
    && curl -L https://github.com/google/fonts/archive/master.tar.gz | tar xfz - \
    && fc-cache -f > /dev/null \
    && rm -rf /var/lib/apt/lists/*

## Configure default locale, see https://github.com/rocker-org/rocker/issues/19
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
    && locale-gen en_US.utf8 \
    && /usr/sbin/update-locale LANG=en_US.UTF-8

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

## Use Debian unstable via pinning -- new style via APT::Default-Release
RUN echo "deb http://http.debian.net/debian sid main" > /etc/apt/sources.list.d/debian-unstable.list \
    && echo 'APT::Default-Release "testing";' > /etc/apt/apt.conf.d/default

ENV R_BASE_VERSION 3.4.1

## Now install R and littler, and create a link for littler in /usr/local/bin
## Also set a default CRAN repo, and make sure littler knows about it too
RUN apt-get update \
    && apt-get install -t unstable -y --no-install-recommends \
        littler \
                r-cran-littler \
        r-base=${R_BASE_VERSION}* \
        r-base-dev=${R_BASE_VERSION}* \
        r-recommended=${R_BASE_VERSION}* \
        && echo 'options(repos = c(CRAN = "https://cran.rstudio.com/"), download.file.method = "libcurl")' >> /etc/R/Rprofile.site \
        && echo 'source("/etc/R/Rprofile.site")' >> /etc/littler.r \
    && ln -s /usr/share/doc/littler/examples/install.r /usr/local/bin/install.r \
    && ln -s /usr/share/doc/littler/examples/install2.r /usr/local/bin/install2.r \
    && ln -s /usr/share/doc/littler/examples/installGithub.r /usr/local/bin/installGithub.r \
    && ln -s /usr/share/doc/littler/examples/testInstalled.r /usr/local/bin/testInstalled.r \
    && MAKE="make -j8" install.r docopt \
    && rm -rf /tmp/downloaded_packages/ /tmp/*.rds \
    && rm -rf /var/lib/apt/lists/*

# Install all the packages we could want. Starting with the fragile snowflakes
ADD bioc.r /usr/local/bin/bioc.r
RUN MAKE="make -j16" R CMD javareconf && install.r rJava && \
    MAKE="make -j16" install.r --error httr && \
    MAKE="make -j16" bioc.r --error biomaRt && \
    rm -rf /tmp/downloaded_packages/ /tmp/*.rds
RUN MAKE="make -j16" install.r --error adabag AER akima ape asd BayesDA boot car caert cgdsr checkmate chron class cluster coda coin colorspace compute.es corrplot coxme curl DAAG data.table DBI digest doBy doMC doParallel DoseFinding dplyr drc e1071 effects ellipse entropy fastICA fields foreach foreign formatR Formula fpc gamm4 gdata gee geepack GGally ggdendro ggplot2 GGtools GLMMGibbs gplots grDevices grid gridBase gridExtra gsDesign gtable hexbin HH highr Hmisc httpuv httr inline intervals ISwR iterators jsonlite kernlab KernSmooth knitr Lahman lattice lawstat lazyeval lme4 lmtest magrittr maps markdown marray MASS Matrix MatrixModels mboost mda mgcv microbenchmark mlbench multcomp multicore mvtnorm mvtnormAPI nlme nloptr nnet nws openssl parallel party pbkrtest pls plyr polspline pROC pryr pspline psych quantreg R6 Rcpp RcppEigen RCurl readr reshape reshape2 rex rggobi rjags rjson Rmpi robust robustbase rootSolve rpart rprojroot rpmv rrcov RSQLite rstan rtracklayer RUnit runjags sandwich scales scrapeR sem shiny snow sparklyr SparkR SparseM spatial splines stringi stringr strucchange survival Sxslt testthat tibble timeDate timeSeries tree treemap tseries TTR uuid vcd VGAM xgobi xlsx XML xtable xts XVector zoo && \
    rm -rf /tmp/downloaded_packages/ /tmp/*.rds
RUN MAKE="make -j16" bioc.r --error affy affydata annotate AnnotationDbi AnnotationHub baySeq Biobase biomaRt Biostrings BSgenome convert ctc DESeq DESeq2 EBSeq edgeR ExomeDepth genefilter GenomeInfoDb genomeIntervals GenomicAlignments GenomicFeatures GenomicRanges GEOquery GO.db golubEsets IRanges KEGG.db KEGGgraph limma microRNA Rsamtools

# Now install Rstudio
## Add RStudio binaries to PATH
ENV PATH /usr/lib/rstudio-server/bin/:$PATH


RUN sh -c "echo 'deb http://ftp.de.debian.org/debian jessie main' >> /etc/apt/sources.list"

## Download and install RStudio server & dependencies
## Attempts to get detect latest version, otherwise falls back to version given in $VER
## Symlink pandoc, pandoc-citeproc so they are available system-wide
RUN rm -rf /var/lib/apt/lists/ \
  && rm /etc/pam.d/sudo \
  && apt-get update \
  && apt-get install -t stable libssl1.0.0 \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y -t unstable --no-install-recommends \
    ca-certificates \
    file \
    git \
    libapparmor1 \
    libedit2 \
    libcurl4-openssl-dev \
    libssl-dev \
    psmisc \
    python-setuptools \
    sudo \
  && VER=1.0.44 \
  && wget -q https://s3.amazonaws.com/rstudio-dailybuilds/rstudio-server-${VER}-amd64.deb \
  && dpkg -i rstudio-server-${VER}-amd64.deb \
  && rm rstudio-server-*-amd64.deb \
  && ln -s /usr/lib/rstudio-server/bin/pandoc/pandoc /usr/local/bin \
  && ln -s /usr/lib/rstudio-server/bin/pandoc/pandoc-citeproc /usr/local/bin \
  && wget https://github.com/jgm/pandoc-templates/archive/1.15.0.6.tar.gz \
  && mkdir -p /opt/pandoc/templates && tar zxf 1.15.0.6.tar.gz \
  && cp -r pandoc-templates*/* /opt/pandoc/templates && rm -rf pandoc-templates* \
  && mkdir /root/.pandoc && ln -s /opt/pandoc/templates /root/.pandoc/templates \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/

## Ensure that if both httr and httpuv are installed downstream, oauth 2.0 flows still work correctly.
RUN echo '\n\
\n# Configure httr to perform out-of-band authentication if HTTR_LOCALHOST \
\n# is not set since a redirect to localhost may not work depending upon \
\n# where this Docker container is running. \
\nif(is.na(Sys.getenv("HTTR_LOCALHOST", unset=NA))) { \
\n  options(httr_oob_default = TRUE) \
\n}' >> /etc/R/Rprofile.site

RUN echo "PATH=$PATH" >> /etc/R/Renviron.site

## Use s6
RUN wget -P /tmp/ https://github.com/just-containers/s6-overlay/releases/download/v1.11.0.1/s6-overlay-amd64.tar.gz \
  && tar xzf /tmp/s6-overlay-amd64.tar.gz -C /

RUN cp /etc/nslcd.conf /etc/pam_ldap.conf
RUN echo "www-port=8788" > /etc/rstudio/rserver.conf
COPY userconf.sh /etc/cont-init.d/conf
COPY run.sh /etc/services.d/rstudio/run

COPY rstudio /etc/pam.d/
EXPOSE 8788

CMD ["/init"]
