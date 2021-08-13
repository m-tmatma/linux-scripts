#!/bin/sh

SCRIPT_DIR=$(cd $(dirname $0);pwd)
docker run \
    -p 3128:3128 \
    -v $SCRIPT_DIR/conf/squid.conf:/etc/squid/squid.conf \
    squid-cache:1 \
    "$@"
