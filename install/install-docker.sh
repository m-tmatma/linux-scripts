#!/bin/sh

sudo apt install -y docker.io docker-compose
sudo usermod -a -G docker $USER

