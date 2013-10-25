# oh-my-zsh settings
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="mortalscumbag"
COMPLETION_WAITING_DOTS="true"
plugins=(git pip autojump)

source $ZSH/oh-my-zsh.sh
source $HOME/.aliases

# enabling autojump autocomplete
# https://github.com/joelthelion/autojump/issues/86
autoload -U compinit; compinit
export AUTOJUMP_IGNORE_CASE=1
export PATH=$HOME/.rvm/bin:$HOME/.bin:/usr/local/share/python:/usr/local/share/npm/bin:/usr/local/sbin:/usr/local/bin:/usr/X11/bin:/usr/sbin:/usr/bin:/sbin:/bin
export EDITOR=vim
export TERM=xterm-256color
#export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH  # for pygit2

if command_exists virtualenvwrapper.sh; then
  export WORKON_HOME=~/.virtualenvs
  export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'
  source virtualenvwrapper.sh
fi

if command_exists gdircolors; then
  export PATH=`brew --prefix`/Cellar/coreutils/8.20/libexec/gnubin:$PATH
fi

if command_exists dircolors; then
  eval `dircolors ~/.dir_colors`
else
  export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD
fi

# ctrl-s for vim
stty -ixon

# python brew
[[ -s $HOME/.pythonbrew/etc/bashrc ]] && source $HOME/.pythonbrew/etc/bashrc
