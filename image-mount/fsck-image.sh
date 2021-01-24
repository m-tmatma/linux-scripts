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

# ループバックデバイス
EXISTING_LOOPBACK=$(losetup -j ${FILENAME} | cut -d ':' -f 1)
if [ -n "${EXISTING_LOOPBACK}" ]; then
    MOUNT_POINTS=$(lsblk -o MOUNTPOINT ${EXISTING_LOOPBACK} | sed -e '1d' | uniq | awk 'NF')

    echo "ERROR:"
    echo "ERROR: ${FILENAME} is already assigned."
    echo "ERROR: run umount-image.sh ${FILENAME} first."
    echo "ERROR:"
    echo "ERROR: mounted at ${EXISTING_LOOPBACK}"
    echo "ERROR: mounted at ${MOUNT_POINTS}"
    exit 1
fi

# Partition number (default is 2)
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
LOOPBACK_DEVICE_PART=${LOOPBACK_DEVICE}p${PARTITION_NUMBER}

# 割り当てたイメージファイルの各パーティションに対応するループバックデバイス名一覧を表示する。
ls -l ${LOOPBACK_DEVICE}*

# Partition 情報を確認する
sudo fdisk -l ${LOOPBACK_DEVICE}

# ファイルシステムのチェックを行う
sudo fsck ${LOOPBACK_DEVICE_PART}

# ループバックデバイスを解放する。
sudo losetup -d ${LOOPBACK_DEVICE}

echo SUCCESS
