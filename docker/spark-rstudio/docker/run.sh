#!/bin/bash
nslcd &
/usr/lib/rstudio-server/bin/rserver --server-daemonize 0 > /dev/stderr

