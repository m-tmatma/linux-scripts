#!/bin/sh

echo $USER ALL=NOPASSWD: /usr/sbin/reboot | sudo tee /etc/sudoers.d/reboot
sudo chmod 440 /etc/sudoers.d/reboot

