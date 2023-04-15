#!/bin/sh

SCRIPT_DIR=$(cd $(dirname $0); pwd)
bash_aliases=${HOME}/.bash_aliases
git_alias=${HOME}/.git_alias

cat $SCRIPT_DIR/git-alias   >> $git_alias
echo ". ~/.git_alias" >> $bash_aliases

