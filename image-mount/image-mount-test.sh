#!/bin/sh -e

# イメージファイルのファイル名
FILENAME=$1

# マウントポイント
MOUNT_POINT=$2

# 引数で指定したイメージをループバックデバイスに関連づける。ループバックデバイス名は変数 LOOPBACK_DEVICE に割り当てる。
LOOPBACK_DEVICE=$(sudo losetup -P --show -f ${FILENAME})

# ループバックデバイス一覧を表示する
losetup -l

# 複数パーティションを含むイメージデータをマウントするときの肝
# 複数パーティションを含むイメージデータをループバックデバイスにマウントすると
# パーティション1 は /dev/loopXXXp1
# パーティション2 は /dev/loopXXXp2
# というように p数字 という suffix がついたデバイスが作られる。
LOOPBACK_DEVICE_P2=${LOOPBACK_DEVICE}p2

# 割り当てたイメージファイルの各パーティションに対応するループバックデバイス名一覧を表示する。
ls -l ${LOOPBACK_DEVICE}*

# 割り当てたループバックデバイスをマウントする
sudo mount ${LOOPBACK_DEVICE_P2} ${MOUNT_POINT}

# マウントしたファイルシステムの中身を確認する
# 必要に応じて書き換えることが可能
sudo ls -l ${MOUNT_POINT}

# マウント解除する。
sudo umount ${MOUNT_POINT}

# ループバックデバイスを解放する。
sudo losetup -d ${LOOPBACK_DEVICE}