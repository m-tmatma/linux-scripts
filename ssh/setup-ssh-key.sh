#!/bin/sh

if [ -e id_rsa.pub ]; then
	mkdir -p ~/.ssh
	cat id_rsa.pub >>  .ssh/authorized_keys
	chmod 755 ~
	chmod 700 ~/.ssh
	chmod 600 ~/.ssh/authorized_keys
	rm  id_rsa.pub
else
	echo "id_rsa.pub doesn't exist"
    exit 1
fi
