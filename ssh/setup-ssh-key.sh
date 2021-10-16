#!/bin/sh

SSH_KEY=~/id_rsa.pub

if [ -e "$SSH_KEY" ]; then
	mkdir -p ~/.ssh
	cat $SSH_KEY >>  ~/.ssh/authorized_keys
	chmod 755 ~
	chmod 700 ~/.ssh
	chmod 600 ~/.ssh/authorized_keys
	rm  $SSH_KEY
else
	echo "$SSH_KEY doesn't exist"
    exit 1
fi
