# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'
ltm() { ls -lt "$@" | more; }

psg () { command ps aux | grep "$@" | grep -v grep ; }
tf () { command tail -f "$@" ; }
tfc () { command tail -f "$@" | ccze -A ; }
alias tfs='tail -f /var/log/syslog'
sti () { command ssh root@$@ ; }
sl () { command surf localhost:$1/$2 & }
sp () { command surf `xclip -o` & }
alias sqlite3='sqlite3 -column -header'
alias grep="/bin/grep --color=auto"

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
alias newest='find . -type f -printf "%C@ %p\n" | sort -rn | head -n'

alias gzip='pigz --rsyncable'

# show non-printing chars, don't process them!
alias cat='cat -v'

alias diff='grc diff'
alias make='grc make'
alias netstat='grc netstat'
alias ping='grc ping'
alias configure='grc ./configure'

alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

alias refresh='source ~/.bashrc'

# will need sudo to listen on low port
alias tftphere='in.tftpd ./ -s -c -L -a 0.0.0.0:69 -4 -vv'

# Bash wrapper to change directory to the output of gocd
gocd () {
  if dir=$($GOPATH/bin/gocd $1); then
    cd "$dir"
  fi
}

# Optional tab completion wrapper for $GOPATH/src
_gopath () {
  local cur
  COMPREPLY=()
  cur=${COMP_WORDS[COMP_CWORD]}
  k=0
  for j in $( compgen -f "$GOPATH/src/$cur" ); do
    if [ -d "$j" ]; then
      COMPREPLY[k++]=${j#$GOPATH/src/}
    fi
  done
}

complete -o nospace -F _gopath gocd 

# aliases from github.com/bkuhlmann/dotfiles
alias bzc='tar --use-compress-program=pigz --create --preserve-permissions --bzip2 --verbose --file'
alias bzx='tar --extract --bzip2 --verbose --file'
alias copf='rubocop --auto-correct'
alias myip='curl --silent checkip.dyndns.org | grep --extended-regexp --only-matching "[0-9.]+"'

# kubernetes commands
# https://mtpereira.com/local-development-k8s.html
alias minikube-start='minikube start --insecure-registry localhost:5000 && eval $(minikube docker-env) && minikube dashboard' # && source <(minikube completion bash)'

# docker shortcuts
function drips(){ 
  docker ps -q | xargs -n 1 docker inspect --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}} {{ .Name }}' | sed 's/ \// /'; 
}

