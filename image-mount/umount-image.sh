#!/bin/sh -ex

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

# 引数で指定したイメージをループバックデバイスに関連づける。ループバックデバイス名は変数 LOOPBACK_DEVICE に割り当てる。
LOOPBACK_DEVICE=$(losetup -j ${FILENAME} | cut -d ':' -f 1)

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

# マウント解除する。
sudo umount ${LOOPBACK_DEVICE_P2}

# ループバックデバイスを解放する。
sudo losetup -d ${LOOPBACK_DEVICE}