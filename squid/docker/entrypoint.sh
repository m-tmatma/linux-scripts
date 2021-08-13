#!/bin/sh

mkdir -p  /var/cache/squid
chmod 777 /var/cache/squid
squid -N -f /etc/squid/squid.conf -z
