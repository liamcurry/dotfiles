#!/usr/bin/env bash

# Much of this was borrowed from a previous script:
# http://goo.gl/xP31p

dotfiles_repo="git://github.com/liamcurry/dotfiles.git"
dotfiles_branch="master"

dir_current=$PWD
dir_downloads="~/Downloads"

packages_brew=(
  curl
  vim
  git
  zsh
  autoclip
  tmux
  mongodb
  node
  reattach-to-user-namespace    # To allow copy/paste in tmux
)

packages_npm=(
  coffee-script
  uglify-js
)

packages_pip=(
  flake8
  virtualenv
)

function _pp {
  echo "--- $1"
}

function _pp_hr {
  echo "--------------------------------------"
}

function _pp_d {
  _pp "Done! Moving on..."
  _pp_hr
}

function _debug {
  _pp "*** DEBUGGING: $1"
}

function _run {
  if [[ $debugging ]]; then
    _debug "Would have ran: $1"
  else
    `$1`
  fi
}

_pp_hr
_pp_hr
_pp_hr

_pp "Installing Homebrew"
_run "ruby -e \"$(curl -fsSkL raw.github.com/mxcl/homebrew/go)\""
_pp_d

_pp "Installing pip"
_run "sudo curl http://python-distribute.org/distribute_setup.py | python"
_run "sudo curl https://raw.github.com/pypa/pip/master/contrib/get-pip.py | python"
_pp_d

_pp "Installing npm"
_run "curl http://npmjs.org/install.sh | sh"
_pp_d

_pp "Installing Homebrew packages..."
_run "brew install ${packages_brew[@]}"

_pp "Installing Python requirements..."
_run "sudo pip install ${packages_pip[@]}"
_pp_d

#_pp "Install Node.js requirements..."
#_run "npm install ${packages_npm[@]}"
#_pp_d

#_pp "Install Ruby requirements..."
#_run "gem install rake compass watchr rb-inotify jekyll lunchy"
#_pp_d

_pp "Getting dotfiles from $dotfiles_repo (branch: $dotfiles_branch)"
cd ~
git init
git remote add -t $dotfiles_branch -f origin $dotfiles_repo
git checkout $dotfiles_branch
_pp_d

_pp "Getting submodules from dotfiles repo"
git submodule update --init --force
git config status.showuntrackedfiles no
_pp_d

_pp "Making ZSH the default shell"
chsh -s /bin/zsh
_pp_d
