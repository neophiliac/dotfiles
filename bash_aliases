# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'
ltm() { ls -lt "$@" | more }

psg () { command ps aux | grep "$@" | grep -v grep ; }
tf () { command tail -f "$@" ; }
sti () { command ssh root@$@ ; }
sl () { command surf localhost:$1/$2 & }
sp () { command surf `xclip -o` & }
alias sqlite3='sqlite3 -column -header'

# rails aliases
alias bi='bundle install | grep nstallin'
alias bup='bundle update | grep nstallin'
alias be="bundle exec"

# go aliases
alias gob='go build -ldflags "-X main.buildstamp `date -u '+%Y-%m-%d_%I:%M:%S%p'` -X main.githash `git rev-parse HEAD`"'
# to get embedded build info with 'gob', add this to your main pkg:
# var (
#   buildstamp = "notset"
#   githash = "notset"
# )

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
