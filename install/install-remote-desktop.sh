#!/bin/sh

sudo apt -y install xrdp tigervnc-standalone-server
sudo systemctl enable xrdp
sudo systemctl start xrdp

sudo apt install -y firewalld
sudo firewall-cmd --add-port=3389/tcp  --permanent
sudo firewall-cmd --reload

