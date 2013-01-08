# oh-my-zsh settings
autoload_dir=$HOME/.custom/autoload
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="cygni"
COMPLETION_WAITING_DOTS="true"
plugins=(git pip autojump)

source $ZSH/oh-my-zsh.sh

# Will load any files you put in .autoload
for file in $(find $autoload_dir -maxdepth 1 -type f -or -type l); do
  source $file
done

# enabling autojump autocomplete
# https://github.com/joelthelion/autojump/issues/86
autoload -U compinit; compinit
export AUTOJUMP_IGNORE_CASE=1
export DEFAULT_USER="cygni"

export PATH=$HOME/.rvm/bin:/usr/local/share/python:/usr/local/share/npm/bin:\
/usr/local/sbin:/usr/local/bin:/usr/X11/bin:/usr/sbin:/usr/bin:/sbin:/bin

export EDITOR=vim
export TERM=xterm-256color

eval `dircolors ~/.dir_colors`
