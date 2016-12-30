FROM debian:jessie

RUN apt-get -y update && \
    DEBIAN_FRONTEND="noninteractive" \
    apt-get --no-install-recommends install -y libnss-ldapd ldap-utils libpam-ldap nscd

ADD nsswitch.conf /etc/
ADD nslcd.conf /etc/
ADD ldap.* /etc/
ADD pam.d /etc/pam.d/
