# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth

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

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
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
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    #alias dir='ls --color=auto --format=vertical'
    #alias vdir='ls --color=auto --format=long'
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
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
#function gitup { if [ -d $1 ]; then (cd $1; git pull; cd -); fi }

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

# set editor for text or X
if [ -n $DISPLAY ]; then
  export EDITOR='vim';
else
  export EDITOR='gvim';
  export VISUAL='gvim';
fi;

export JDK_HOME="/usr/lib/jvm/java-7-openjdk-amd64/"

export CDPATH=~/Projects:"${CDPATH}"

export CHOST="x86_64-pc-linux-gnu"
export CFLAGS="-march=corei7-avx -O2 -pipe"
export CXXFLAGS="${CFLAGS}"
export NUMCPUS=`grep -c '^processor' /proc/cpuinfo`
export MAKEOPTS="-j$((NUMCPUS*2))"
export MAKEFLAGS="-j$((NUMCPUS*2))"
alias pmake='time nice make -j$((NUMCPUS*2)) --load-average=$NUMCPUS'

export GREP_OPTIONS='--color=auto'

# Ibus env
#export GTK_IM_MODULE=ibus
#export XMODIFIERS=@im=ibus
#export QT_IM_MODULE=ibus

# GNOME keyring
#export GNOME_DESKTOP_SESSION_ID=`pidof gnome-keyring-daemon`
#export GNOME_DESKTOP_SESSION_ID=1

source ~/.bash_prompt

# Ruby2 tuning
export RUBY_GC_MALLOC_LIMIT=1000000000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1.25
#export RUBY_HEAP_MIN_SLOTS=800000
export RUBY_GC_HEAP_INIT_SLOTS=800000 # Like RUBY_HEAP_MIN_SLOTS for Ruby 2.1+
#export RUBY_FREE_MIN=600000
export RUBY_GC_HEAP_FREE_SLOTS=600000 # Like RUBY_FREE_MIN for Ruby 2.1+
#export LD_PRELOAD=/usr/lib/libtcmalloc_minimal.so.4
export LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libjemalloc.so.1

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init - --no-rehash)"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# Android tools (for Ruboto)
export PATH="$HOME/android-sdk-linux/tools:$PATH"
export ANDROID_HOME="$HOME/android-sdk-linux"

# golang env
export GOROOT=$HOME/tools/go/go-lang
export PATH=$PATH:$GOROOT/bin
export GOPATH="/home/kls/Projects/gocode/"

##*- MUST BE LAST LINE!!
eval "$(direnv hook bash)"
