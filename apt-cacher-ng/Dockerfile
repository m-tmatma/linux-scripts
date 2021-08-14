# see https://runebook.dev/ja/docs/docker/engine/examples/apt-cacher-ng/index
#
# ビルド：docker build -t apt-cacher
# 実行：docker run -d -p 3142：3142 --name apt-cacher-run apt-cacher
#
# 次に、次のコマンドでコンテナを実行できます。
#   docker run -t -i --rm -e http_proxy http://dockerhost:3142/ debian bash
#
# ここで、 `dockerhost`は、Dockerデーモンを実行しているホストのIPアドレスまたはFQDNです。
# APTプロキシサーバーとして機能します。
FROM        ubuntu

VOLUME      ["/var/cache/apt-cacher-ng"]
RUN     apt-get update && apt-get install -y apt-cacher-ng

EXPOSE      3142
CMD     chmod 777 /var/cache/apt-cacher-ng && /etc/init.d/apt-cacher-ng start && tail -f /var/log/apt-cacher-ng/*
