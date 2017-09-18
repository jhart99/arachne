FROM vogt1005.scripps.edu:5000/ldap

WORKDIR /usr/local

RUN apt-get -y update && \
    apt-get --no-install-recommends -y install python2.7 && \
    rm -rf /var/lib/apt/lists/*
