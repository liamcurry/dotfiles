#!/usr/bin/env zsh
#
command_exists () {
  type "$1" &> /dev/null ;
}

alias mk='mkdir -p'

alias lsa='ls --color=auto -la'

# git
alias gd='git diff'
alias gs='git status'
alias gci='git commit'
alias gl='git log'
alias glp='git log -p'
alias gv='git svn'
alias gr='git rebase'
alias gb='git branch'

# Package management stuff
if command_exists apt-get; then
  alias pkgs='apt-cache search'
  alias pkgi='sudo apt-get install'
  alias pkgr='sudo apt-get remove'
elif command_exists brew; then
  alias pkgs='brew search'
  alias pkgi='brew install'
  alias pkgr='brew remove'
elif command_exists port; then
  alias pkgs='apt-cache search'
  alias pkgi='sudo apt-get install'
  alias pkgr='sudo apt-get autoremove --purge'
fi

# helpers
alias src='source .ve/bin/activate'
alias server='python -m SimpleHTTPServer'
alias styl='stylus --watch --use nib'

# Copy/paste from clipboard
if command_exists xclip; then
  alias copy='xclip -sel clip <'
elif command_exists pbcopy; then
  alias copy='pbcopy <'
fi

# One of @janmoesen’s ProTip™s
for method in GET HEAD POST PUT DELETE TRACE OPTIONS; do
  alias "$method"="lwp-request -m '$method'"
done

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en1"
alias ips="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"

# Enhanced WHOIS lookups
alias whois="whois -h whois-servers.net"

# Flush Directory Service cache
alias flush="dscacheutil -flushcache"

# Easier navigation: .., ..., ~ and -
alias ..="cd .."
alias ...="cd ../.."
alias ~="cd ~" # `cd` is probably faster to type though
alias -- -="cd -"

# Fix crontab backups with vim. See .vimrc for more info, or http://goo.gl/LP6X0
alias crontab="VIM_CRONTAB=true crontab"

# Fix tmux colors being shitty with vim in ubuntu for some reason
# http://stackoverflow.com/q/10158508/105428
alias tmux="tmux -2"
