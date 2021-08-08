#!/bin/sh

SCRIPT_DIR=$(cd $(dirname $0); pwd)
OUTPUT=${HOME}/.bash_aliases

cat $SCRIPT_DIR/git-alias >> $OUTPUT

