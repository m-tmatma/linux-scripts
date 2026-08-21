co() {
    git rev-parse --is-inside-git-dir > /dev/null 2>&1 || return
    local selected
    selected=$(git branch -a | grep -v '/HEAD' | peco | sed -r 's#^\*?\s+##')
    [ -z "$selected" ] && return
    local -a cmd
    if [[ "$selected" == remotes/* ]]; then
        local remote_branch=${selected#remotes/}
        local remote=${remote_branch%%/*}
        local branch=${remote_branch#*/}
        if git show-ref --verify --quiet "refs/heads/$branch"; then
            cmd=(git checkout "$branch")
        else
            cmd=(git checkout -b "$branch" "$remote/$branch")
        fi
    else
        cmd=(git checkout "$selected")
    fi
    echo "${cmd[*]}"
    "${cmd[@]}"
}
