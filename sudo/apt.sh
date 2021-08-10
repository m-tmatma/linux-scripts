#!/bin/sh

echo $USER ALL=NOPASSWD: /usr/sbin/apt | sudo tee /etc/sudoers.d/apt
sudo chmod 440 /etc/sudoers.d/apt

