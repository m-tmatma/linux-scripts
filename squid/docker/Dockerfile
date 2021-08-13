FROM ubuntu:20.04
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y \
 && apt-get install squid3 -y \
 && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

EXPOSE 3128

COPY entrypoint.sh /entrypoint.sh
RUN  chmod 755 /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
