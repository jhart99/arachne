FROM vogt1005.scripps.edu:5000/python2.7

WORKDIR /usr/local

RUN apt-get update && \
    apt-get install -y python-pip && \
    pip install web.py

RUN mkdir ipxeman
ADD files/* ipxeman/
WORKDIR /usr/local/ipxeman

