# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="miloshadzic"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git github node npm osx pip autojump)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/usr/local/bin:/usr/local/share/python:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:/usr/local/git/bin:/usr/local/nginx/bin:/usr/local/pgsql/bin:/opt/local/bin:/opt/local/sbin:/usr/local/mysql/bin:/usr/local/bin
#export PATH=/usr/local/share/python:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:/usr/local/git/bin:/usr/local/nginx/bin/:/usr/local/pgsql/bin:/opt/local/bin:/opt/local/sbin:/usr/local/mysql/bin/:/usr/local/bin
#export PYTHONPATH=$(brew --prefix)/lib/python2.7/site-packages:$PYTHONPATH
export PGDATA=/usr/local/pgsql/data
#export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:/usr/local/mysql/lib/
export DJANGO_COLORS="dark"
export EDITOR=vim
export TERM="xterm-256color"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
export NODE_PATH=/usr/local/lib/jsctags/:
export TMPDIR=/tmp
export TMP=/private/tmp

# Loads other files
source ~/.aliases

