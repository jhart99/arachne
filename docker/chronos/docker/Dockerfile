FROM vogt1005.scripps.edu:5000/mesos

WORKDIR /usr/local

# install chronos
RUN apt-get -y update && \
    apt-get -y --no-install-recommends install chronos && \
    rm -rf /var/lib/apt/lists/*

ADD files/start_chronos.sh /usr/local/bin
CMD start_chronos.sh
