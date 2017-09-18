FROM debian:stretch

RUN apt-get update && \
    DEBIAN_FRONTEND="noninteractive" \
    apt-get install --no-install-recommends -y isc-dhcp-server && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["dhcpd","-f"]
