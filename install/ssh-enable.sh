#!/bin/sh

sudo apt install -y openssh-server
sudo systemctl start ssh
sudo systemctl enable ssh
