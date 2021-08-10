#!/bin/sh

SCRIPT_DIR=$(cd $(dirname $0); pwd)
CACHE_DIR=$SCRIPT_DIR/cache

mkdir -p $CACHE_DIR

docker run -d -p 3128:3128 \
	-v $CACHE_DIR:/var/spool/squid \
	minimum2scp/squid

