ZSH=$HOME/.oh-my-zsh
ZSH_THEME="mortalscumbag"
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

#Dunno if I need this shit or not
#export PERL_LOCAL_LIB_ROOT="/home/cygni/perl5";
#export PERL_MB_OPT="--install_base /home/cygni/perl5";
#export PERL_MM_OPT="INSTALL_BASE=/home/cygni/perl5";
#export PERL5LIB="/home/cygni/perl5/lib/perl5/x86_64-linux-gnu-thread-multi:/home/cygni/perl5/lib/perl5";
#export PATH="/home/cygni/perl5/bin:$PATH";
