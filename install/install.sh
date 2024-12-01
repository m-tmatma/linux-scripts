#!/bin/sh

# 事前準備：必要な依存関係のインストール
sudo apt-get update
sudo apt-get install -y \
    apt-transport-https \
    curl \
    avahi-daemon \
    ufw \
    openssh-server \
    docker.io \
    docker-compose \
    samba  # 追加

# VSCode リポジトリの設定とインストール
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

# GitHub CLI リポジトリの設定
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null

# 追加したリポジトリからのパッケージをインストール
sudo apt-get update
sudo apt-get install -y code gh

# サービスの設定と起動
sudo systemctl start  avahi-daemon ssh smbd
sudo systemctl enable avahi-daemon ssh smbd

# ファイアウォールの設定
sudo ufw enable
sudo ufw allow ssh
sudo ufw allow 5353/udp comment 'mDNS'
sudo ufw allow samba  # 追加

# Dockerグループにユーザーを追加
sudo usermod -a -G docker $USER

echo "全てのインストールが完了しました。変更を適用するために再起動することをお勧めします。"
