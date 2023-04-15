#!/bin/sh

SCRIPT_DIR=$(cd $(dirname $0); pwd)
bash_aliases=${HOME}/.bash_aliases
git_alias=${HOME}/.git_alias

cp -f $SCRIPT_DIR/git-alias $git_alias

cat ~/.bash_aliases | grep -v .git_alias > ~/.bash_aliases2
mv  ~/.bash_aliases2 ~/.bash_aliases
echo ". ~/.git_alias" >> $bash_aliases

tail $bash_aliases
