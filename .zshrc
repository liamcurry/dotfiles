ZSH=$HOME/.oh-my-zsh
ZSH_THEME="miloshadzic"
COMPLETION_WAITING_DOTS="true"
plugins=(git github node npm osx pip autojump)

source $ZSH/oh-my-zsh.sh

export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/X11/bin:/usr/local/bin:/usr/local/sbin:/usr/local/share/python:$HOME/.rvm/bin
export EDITOR=vim
export LANG="en_US.UTF-8"
export LC_ALL=$LANG
export TMPDIR=/private/tmp
export TMP=$TMPDIR

source ~/.aliases
