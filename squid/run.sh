#!/bin/sh

SCRIPT_DIR=$(cd $(dirname $0);pwd)
ACTION=$1

OPTION=
COMMAND=
if [ x"$ACTION" = x"bash" ]; then
    OPTION=-it
    COMMAND=bash
fi

docker run \
    $OPTION -p 3128:3128 \
    -v $SCRIPT_DIR/conf/squid.conf:/etc/squid/squid.conf \
    squid-cache:1 $COMMAND
