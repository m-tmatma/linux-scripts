#!/bin/sh

docker run  --name proxy-squid --restart=always -d -p 3128:3128 minimum2scp/squid
