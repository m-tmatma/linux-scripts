#!/bin/sh

sudo apt       install -y avahi-daemon
sudo systemctl start      avahi-daemon
sudo systemctl enable     avahi-daemon

sudo apt install -y firewalld
sudo firewall-cmd --add-service=mdns  --permanent
sudo firewall-cmd --reload
