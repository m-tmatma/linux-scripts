#!/bin/sh

echo 'Defaults env_keep = "http_proxy https_proxy"' | sudo tee /etc/sudoers.d/proxy
sudo chmod 440 /etc/sudoers.d/proxy

