#!/bin/sh

sudo apt       install -y samba 
sudo systemctl start      smbd
sudo systemctl start      nmbd
sudo systemctl enable     smbd
sudo systemctl enable     nmbd

 
