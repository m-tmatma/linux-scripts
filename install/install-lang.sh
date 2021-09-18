#!/bin/sh

# see https://www.hiroom2.com/2016/05/13/ubuntu-16-04%E3%81%AE%E4%B8%8D%E5%AE%8C%E5%85%A8%E3%81%AA%E8%A8%80%E8%AA%9E%E3%82%B5%E3%83%9D%E3%83%BC%E3%83%88%E3%82%92%E4%BF%AE%E6%AD%A3%E3%81%97%E3%81%A6%E6%97%A5%E6%9C%AC%E8%AA%9E%E5%AF%BE%E5%BF%9C%E3%81%99%E3%82%8B/

sudo mkdir -p /usr/share/locale-langpack/ja
sudo apt install -y language-pack-gnome-ja language-pack-gnome-ja-base \
language-pack-ja language-pack-ja-base \
fonts-takao-gothic fonts-takao-mincho \
$(check-language-support)
