#!/bin/sh

mkdir -p cache/apt-cacher-ng

docker run -d -p 3142:3142 \
	-v $(pwd)/cache:/var/cache \
	apt-cacher-ng:1

