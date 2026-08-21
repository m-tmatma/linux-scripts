if [ -e /etc/bash_completion.d/git-prompt ]; then
    source /etc/bash_completion.d/git-prompt
    PS1='\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] $(__git_ps1 " (%s)") \$ '
fi

co() {
    git rev-parse --is-inside-git-dir > /dev/null 2>&1 || return
    local selected
    selected=$(git branch -a | grep -v '/HEAD' | peco | sed -r 's#^\*?\s+##')
    [ -z "$selected" ] && return
    if [[ "$selected" == remotes/* ]]; then
        local remote_branch=${selected#remotes/}
        local remote=${remote_branch%%/*}
        local branch=${remote_branch#*/}
        git checkout -b "$branch" "$remote/$branch" 2>/dev/null || git checkout "$branch"
    else
        git checkout "$selected"
    fi
}

alias p='git push origin HEAD -u'
alias pf='git push origin HEAD -u --force-with-lease'
alias rh='git rev-parse --short HEAD'
alias f='git rev-parse HEAD'
alias s='git show -s'
alias r='git fetch -p --all --tags'
alias up='sudo apt update ; sudo apt upgrade -y ; sudo apt autoremove -y'
alias u='find . -maxdepth 5 -name HEAD  2> /dev/null  |   grep .git/HEAD               |   sed -e "s#/.git/HEAD##"      |   sed -e "s#.git/HEAD#.git#"   |   xargs -r -I{} sh -cx "git -C {} remote update -p"'
alias pull='git pull -p'
alias cleanup='default=$(git remote show origin | sed -n "/HEAD branch/s/.*: //p"); git checkout "$default" && git branch --merged "$default" | grep -vE "(^\*|^[[:space:]]*${default}\$)" | xargs -r git branch -d'

if [ -e /etc/bash_completion.d/git-prompt ]; then
    source /etc/bash_completion.d/git-prompt
    PS1='\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] $(__git_ps1 " (%s)") \$ '
fi

co() {
    git rev-parse --is-inside-git-dir > /dev/null 2>&1 || return
    local selected
    selected=$(git branch -a | grep -v '/HEAD' | peco | sed -r 's#^\*?\s+##')
    [ -z "$selected" ] && return
    if [[ "$selected" == remotes/* ]]; then
        local remote_branch=${selected#remotes/}
        local remote=${remote_branch%%/*}
        local branch=${remote_branch#*/}
        git checkout -b "$branch" "$remote/$branch" 2>/dev/null || git checkout "$branch"
    else
        git checkout "$selected"
    fi
}

alias p='git push origin HEAD -u'
alias pf='git push origin HEAD -u --force-with-lease'
alias rh='git rev-parse --short HEAD'
alias f='git rev-parse HEAD'
alias s='git show -s'
alias up='sudo apt update ; sudo apt upgrade -y ; sudo apt autoremove -y'
alias syncfork='gh repo list --limit 200  --fork --json nameWithOwner  --jq '\''.[].nameWithOwner'\'' | xargs -I{} -n1  sh -x -c "gh repo sync {}"'

if [ -f ~/.git_alias ]; then
    . ~/.git_alias
fi

