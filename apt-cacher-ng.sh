#!/bin/sh

mkdir -p cache/apt-cacher-ng

docker run -d -p 3142:3142 \
	-v $(pwd)/cache/apt-cacher-ng:/var/cache/apt-cacher-ng \
	apt-cacher-ng:1

