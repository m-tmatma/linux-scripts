#!/bin/sh -e

# イメージファイルのファイル名
FILENAME=$1
if [ x${FILENAME} = x"" ]; then
    echo no parameter.
    exit 1
fi

FILENAME=$(readlink -f ${FILENAME})
if [ ! -e ${FILENAME} ]; then
    echo ${FILENAME} does not exist.
    exit 1
fi

# Partition number
PARTITION_NUMBER=${2:-2}

# マウントポイント
MOUNT_POINT=${3:-$(pwd)/mnt/partition${PARTITION_NUMBER}}

# enable verbose output
echo ----------------- enable verbose output -----------------
set -x

# 引数で指定したイメージをループバックデバイスに関連づける。ループバックデバイス名は変数 LOOPBACK_DEVICE に割り当てる。
LOOPBACK_DEVICE=$(sudo losetup -P --show -f ${FILENAME})

# ループバックデバイス一覧を表示する
losetup -l

# 複数パーティションを含むイメージデータをマウントするときの肝
# 複数パーティションを含むイメージデータをループバックデバイスにマウントすると
# パーティション1 は /dev/loopXXXp1
# パーティション2 は /dev/loopXXXp2
# というように p数字 という suffix がついたデバイスが作られる。
LOOPBACK_DEVICE_P2=${LOOPBACK_DEVICE}p${PARTITION_NUMBER}

# 割り当てたイメージファイルの各パーティションに対応するループバックデバイス名一覧を表示する。
ls -l ${LOOPBACK_DEVICE}*

if [ ! -e $MOUNT_POINT ]; then
    mkdir -p $MOUNT_POINT
fi

# 割り当てたループバックデバイスをマウントする
sudo mount ${LOOPBACK_DEVICE_P2} ${MOUNT_POINT}

# マウントしたファイルシステムの中身を確認する
# 必要に応じて書き換えることが可能
sudo ls -l ${MOUNT_POINT}
