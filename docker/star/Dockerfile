FROM phusion/baseimage:latest
MAINTAINER jonathan@jonathanrosshart.com

WORKDIR /usr/local

RUN apt-get update && apt-get install -y gawk

RUN curl https://codeload.github.com/alexdobin/STAR/tar.gz/STAR_2.4.2a > STAR.tar.gz && \
    tar xfvz STAR.tar.gz && \
    ln -s /usr/local/STAR-STAR_2.4.2a/bin/Linux_x86_64_static/STAR /usr/local/bin

# WORKDIR /usr/local/STAR-STAR_2.4.1c

ADD GTF.awk /usr/local/bin/
ADD index /usr/local/bin/
ADD align.* /usr/local/bin/
