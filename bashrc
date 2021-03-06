# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# history config from mrzool
export HISTCONTROL="erasedups:ignoreboth"
export HISTTIMEFORMAT='%F %T '
export HISTIGNORE="&:[ ]*:bg:fg:history"
shopt -s histappend
shopt -s cmdhist

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# use git macros if they are available
if [ -f /etc/bash_completion.d/git ]; then
    export GIT_PS1_SHOWDIRTYSTATE=true
    export GIT_PS1_SHOWUNTRACKEDFILES=true
    export GIT_PS1_SHOWSTASHSTATE=true
    export GIT_PS1_SHOWUPSTREAM="auto"
    . /etc/bash_completion.d/git
fi

# create aliases for Git commands from ~/.gitconfig
# perl -pe '$c=$1if/^\[(.*)\]/;$_=join("\t",($c,$1,$2))if/^\s*(\w*?)\s*=\s*([^=]*$)/;' < $HOME/.gitconfig | grep '^alias\b' | cut -f2- | while read git_alias git_command; do
#   alias $git_alias="git $git_command"
# done
# unset git_alias git_command

# set a fancy prompt (non-color, unless we know we "want" color)
# and other term-specific config
case "$TERM" in
xterm-kitty)
    source <(kitty + complete setup bash)
    ;;
xterm-color)
    PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
    ;;
screen)
    PS1='[\u@\h]\$ '
    ;;
*)
    PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
    #PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    ;;
esac

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# if a /usr/local completion directory exists, source all files
if [ -d /usr/local/etc/bash_completion.d ]; then
  for f in /usr/local/etc/bash_completion.d/* 
  do
    . $f
  done
fi

# battery status
function b0 {
  # Returns battery charge as a percentage.
  now=`cat /sys/class/power_supply/BAT0/energy_now`
  full=`cat /sys/class/power_supply/BAT0/energy_full`
  out=`echo $now/$full*100 | bc -l | cut -c 1-5`
  echo "Charge: "$out"%"
}

# utility functions
function lt() { ls -ltrsa "$@" | tail; }
function psgrep() { ps axuf | grep -v grep | grep "$@" -i --color=auto; }
function fname() { find . -iname "*$@*"; }

# cd bookmarks
# enable custom tab completion
shopt -s progcomp
# jump to bookmark
function g {
  source ~/.sdirs
  cd $(eval $(echo echo $(echo \$DIR_$1)))
}
# list bookmarks without dirname
function _l {
  source ~/.sdirs
  env | grep "^DIR_" | cut -c5- | grep "^.*=" | cut -f1 -d "="
}
# completion command for g
function _gcomp {
  local curw
  COMPREPLY=()
  curw=${COMP_WORDS[COMP_CWORD]}
  COMPREPLY=($(compgen -W '`_l`' -- $curw))
  return 0
}
# bind completion command for g to _gcomp
complete -F _gcomp g
# Usage: g [TAB]
# --- end cd bookmarks

# AWS command completion
complete -C '/usr/local/bin/aws_completer' aws

# set editor and related aliases
export EDITOR='nvim';
alias vimdiff='nvim -d'
alias vim="nvim"
alias vi="nvim"

export JDK_HOME="/usr/lib/jvm/java-7-openjdk-amd64/"

export CHOST="x86_64-pc-linux-gnu"
#export CFLAGS="-march=corei7-avx -O2 -pipe"
export CFLAGS="-march=native -O2 -pipe -D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS -fstack-protector-strong -fstack-clash-protection -fPIE -pie -Wl,-z,noexecstack -Wl,-z,relro -Wl,-z,now"
export CXXFLAGS="${CFLAGS}"
export NUMCPUS=`grep -c '^processor' /proc/cpuinfo`
export MAKEOPTS="-j$((NUMCPUS))"
export MAKEFLAGS="$(MAKEOPTS)"
alias pmake='time nice make -j$((NUMCPUS*2)) --load-average=$NUMCPUS'

source ~/.bash_prompt

# Ruby2 tuning
export RUBY_GC_MALLOC_LIMIT=1000000000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1.25
export RUBY_GC_HEAP_INIT_SLOTS=800000 # Like RUBY_HEAP_MIN_SLOTS for Ruby 2.1+
export RUBY_GC_HEAP_FREE_SLOTS=600000 # Like RUBY_FREE_MIN for Ruby 2.1+
export LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libjemalloc.so.2

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# AWS env
export AWS_CONFIG_FILE=$HOME/.aws/config

# Android tools
#export PATH="$HOME/tools/android/android-studio/bin:$PATH"
#export ANDROID_HOME="$HOME/tools/android/android-studio"

# golang env
export GOROOT=/usr/local/go
export PATH=$PATH:$GOROOT/bin
export GOPATH="/home/kls/Projects/gocode"
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN

# cd path and options, for interactive shell only
if test "${PS1+set}"; then
  export CDPATH=.:~:~/Projects:"${GOPATH}/src/github.com/neophiliac":"${GOPATH}/src/github.com/bright-lion"
  shopt -s autocd
  shopt -s dirspell
  shopt -s cdspell
fi
# another cdpath-ish thing
# source ~/bin/wd.sh
# wd --add $GOPATH/src/github.com
# wd --add ~/Projects

# python env
export PATH=$PATH:$HOME/.local/bin

# vagrant setup (avoid using VirtualBox)
VAGRANT_DEFAULT_PROVIDER=libvirt

# Postgres
export PGUSER=kls
export PGPASSWORD=arfarf

export BORG_PASSPHRASE='speakfriend'

# xtensa path
## set in .envrc where needed!
#export PATH="$PATH:/opt/esp8266/esp-open-sdk/xtensa-lx106-elf/bin"
export IDF_PATH=$HOME/Projects/esp/ESP8266_RTOS_SDK

# ssh agent (keychain)
eval `keychain --eval --agents ssh ~/.ssh/id_*`

# The next line enables shell command completion for gcloud.
source '/usr/share/google-cloud-sdk/completion.bash.inc'
source <(kubectl completion bash)

# PlatfomIO completion
export PATH=$PATH:~/.platformio/penv/bin
eval "$(_PLATFORMIO_COMPLETE=source platformio)"
eval "$(_PIO_COMPLETE=source pio)"

# Vagrant completion
if [ -f /opt/vagrant/embedded/gems/2.2.7/gems/vagrant-2.2.7/contrib/bash/completion.sh ]; then
  . /opt/vagrant/embedded/gems/2.2.7/gems/vagrant-2.2.7/contrib/bash/completion.sh
fi
# rbenv comfig
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init - --no-rehash)"

# jump - https://github.com/gsamokovarov/jump
# 'smart' cd replacement
#eval "$(jump shell)"

##*- MUST BE LAST LINE!!
eval "$(direnv hook bash)"

#command -v vg >/dev/null 2>&1 && eval "$(vg eval --shell bash)"
