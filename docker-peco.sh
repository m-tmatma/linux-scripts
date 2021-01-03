#!/bin/sh
# original code is https://qiita.com/yuta-ron/items/65861ca75bd0990d0065
alias dps='docker ps --format "{{.ID}}\t{{.Image}}\t{{.Status}}\t{{.Command}}\t{{.RunningFor}}"'
alias dexec='docker exec -it $(dps | peco | cut -f 1) bash'
alias dstop='docker stop     $(dps | peco | cut -f 1)'
alias dlogs='docker logs     $(dps | peco | cut -f 1)'
