# oh-my-zsh settings
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="mortalscumbag"
COMPLETION_WAITING_DOTS="true"
plugins=(git pip autojump)

# Source files
source $ZSH/oh-my-zsh.sh
source ~/.aliases

# autojump stuff
# if you have issues with autocomplete, see
# https://github.com/joelthelion/autojump/issues/86
autoload -U compinit; compinit
export AUTOJUMP_IGNORE_CASE=1

# other env variables
export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/X11/bin:/usr/local/bin:/usr/local/sbin:/usr/local/share/python:$HOME/.rvm/bin
export EDITOR=vim
