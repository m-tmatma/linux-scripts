#!/bin/sh

SCRIPT_DIR=$(cd $(dirname $0);pwd)
docker build -t squid-cache:1 $SCRIPT_DIR/docker

