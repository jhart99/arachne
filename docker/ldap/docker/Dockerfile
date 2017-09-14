FROM debian:stretch

RUN apt-get -y update && \
    DEBIAN_FRONTEND="noninteractive" \
    apt-get --no-install-recommends install -y libnss-ldapd ldap-utils libpam-ldap nscd && \
    rm -rf /var/lib/apt/lists/*

ADD nsswitch.conf /etc/
ADD nslcd.conf /etc/
ADD ldap.* /etc/
ADD pam.d /etc/pam.d/
