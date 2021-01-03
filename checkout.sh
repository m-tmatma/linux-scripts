alias co='git rev-parse --is-inside-git-dir > /dev/null 2>&1 \
  && git checkout $(git branch -a | grep -v "/HEAD" | peco | sed -r "s#^\\s+remotes/origin/##" | sed -r "s#^\*\s+##")'
