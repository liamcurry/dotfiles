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
export PATH=$HOME/.rvm/bin:/usr/local/share/python:/usr/local/sbin:/usr/local/bin:/usr/X11/bin:/usr/sbin:/usr/bin:/sbin:/bin
export EDITOR=vim
