FROM ubuntu:20.04
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y \
 && apt-get install squid3 -y \
 && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

