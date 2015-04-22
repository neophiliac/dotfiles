# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

psg () { command ps aux | grep "$@" | grep -v grep ; }
alias stl='(ssh -l kls -L 8080:legs:8080 -L 8089:192.168.33.249:80 legs.merlot.com)'
alias stm='(ssh -X -l kls -L 7070:localhost:8080 merlot.com)'
alias stpw='(ssh -X -l deploy dev.permitwatch.com)'
tf () { command tail -f "$@" ; }
sti () { command ssh root@$@ ; }
sl () { command surf localhost:$1/$2 & }
sp () { command surf `xclip -o` & }
#alias sg='(script/generate $@)'
alias sqlite3='sqlite3 -column -header'
#alias ack=/usr/local/bin/ack

# rails aliases
alias wrp='(git-gui & gvim . )'
alias r='rails'
alias bi='bundle install | grep nstallin'
alias bup='bundle update | grep nstallin'
alias be="bundle exec"

# git shell aliases
alias homegit="GIT_DIR=~/Projects/dotfiles-kls/.git GIT_WORK_TREE=~ git"
alias cdg='cd $(git rev-parse --show-cdup)'

alias nv='nvim'

alias diff='grc diff'
alias make='grc make'
alias netstat='grc netstat'
alias ping='grc ping'
alias configure='grc ./configure'

alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
