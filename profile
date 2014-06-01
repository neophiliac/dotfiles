# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes golang tools
if [ -d "/usr/local/go" ] ; then
    export PATH=$PATH:/usr/local/go/bin
fi

#export RUBY_HEAP_MIN_SLOTS=1000000
#export RUBY_HEAP_SLOTS_INCREMENT=1000000
#export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
#export RUBY_GC_MALLOC_LIMIT=1000000000
#export RUBY_HEAP_FREE_MIN=500000
export LANGUAGE="en_US:en"
export LC_MESSAGES="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"

#function rmb {
#  current_branch=$(git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
#  if [ "$current_branch" != "master" ]; then
#    echo "WARNING: You are on branch $current_branch, NOT master."
#  fi
#    echo "Fetching merged branches..."
#  git remote prune origin
#  remote_branches=$(git branch -r --merged | grep -v '/master$' | grep -v "/$current_branch$")
#  local_branches=$(git branch --merged | grep -v 'master$' | grep -v "$current_branch$")
#  if [ -z "$remote_branches" ] && [ -z "$local_branches" ]; then
#    echo "No existing branches have been merged into $current_branch."
#  else
#    echo "This will remove the following branches:"
#    if [ -n "$remote_branches" ]; then
#      echo "$remote_branches"
#    fi
#    if [ -n "$local_branches" ]; then
#      echo "$local_branches"
#    fi
#    read -p "Continue? (y/n): " -n 1 choice
#    echo
#    if [ "$choice" == "y" ] || [ "$choice" == "Y" ]; then
#      # Remove remote branches
#      git push origin `git branch -r --merged | grep -v '/master$' | grep -v "/$current_branch$" | sed 's/origin\//:/g' | tr -d '\n'`
#      # Remove local branches
#      git branch -d `git branch --merged | grep -v 'master$' | grep -v "$current_branch$" | sed 's/origin\///g' | tr -d '\n'`
#    else
#      echo "No branches removed."
#    fi
#  fi
#}

ddate +'Today is %{%A, the %e of %B%}, %Y. %N%nCelebrate %H'

