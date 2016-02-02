FROM debian:7.7
MAINTAINER jonathan@jonathanrosshart.com

WORKDIR /usr/local

RUN apt-get update && \
    apt-get --no-install-recommends install -y gawk curl ca-certificates && \
    rm -rf /var/lib/apt/lists/*

RUN curl https://codeload.github.com/alexdobin/STAR/tar.gz/STAR_2.4.2a | tar xvz && \
    cp /usr/local/STAR-STAR_2.4.2a/bin/Linux_x86_64_static/STAR /usr/local/bin && \
    rm -rf STAR-STAR_2.4.2a/*

ADD files/* /usr/local/bin/
