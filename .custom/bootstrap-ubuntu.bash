#!/usr/bin/env bash

dotfiles_repo="git://github.com/liamcurry/dotfiles.git"
dotfiles_branch="master"

dir_current=$PWD
dir_downloads="~/Downloads"

guake_hotkey="<Control>semicolon"

# Packages to be installed via apt
packages_apt=(
  curl
  vim-gnome             # vim-gnome lets us use clipboard
  git
  zsh
  xclip                 # Allows copying text to the clipboard
  autojump              # Allows quickly switch directories with partial names
  tmux                  # A nicer alternative to screen
  rubygems
  dropbox
  google-chrome-beta
  synergy
  vlc
  virtualbox
  indicator-multiload   # Really nice indicator that shows cpu/network/memory load
  indicator-weather
  mongodb
  redis-server
  tidy
  csstidy
)

# Any packages not in the default sources
packages_apt_alt=(
  spotify-client
)

# Sources for packages not in defaults
packages_apt_alt_srcs=()

# URLs for debian install files to download
packages_deb=()

# URLs for tar packages to ./configure && make && make install
packages_tar=(
  "http://nodejs.org/dist/v0.8.9/node-v0.8.9-linux-x64.tar.gz"
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

_pp "Allowing you to run sudo without a password"
_run "sudo echo \"\\n$USER ALL=NOPASSWD: ALL\" >> /etc/sudoers"
_pp_d

_pp "Installing apt-get packages..."
cmd_apt="sudo apt-get install -y ${packages_apt[@]}"
if [[ $debugging ]]; then
  _debug "$cmd_apt"
else
  `$cmd_apt`
fi
_pp_d

_pp "Downloading debian packages..."
_run "mkdir -p $dir_downloads && cd $dir_downloads"
_run "wget ${packages_deb[@]} ${packages_tar[@]}"
_pp_d


_pp "Installing debian packages..."
for package in ${packages_deb[@]}; do
  _pp "Installing $package_filename"
  package_filename="${package##*/}"
  package_filename="${package_filename%%\?*}"
  sudo dpkg -i "$package_filename"
done
_pp_d

# Extract and install tar packages
for package in ${packages_tar[*]}; do
  _pp "Installing $package_filename"
  package_filename="${package##*/}"
  package_filename="${package_filename%%\?*}"
  package_basename="${package_filename%*.tar.gz}"
  _run "tar -xf $package_filename"
  _run "cd $package_basename"
  _run "./configure && make && sudo make install"
done

# Add sources for the package manager
_pp "Adding sources to /etc/apt/sources.list"
for src in ${packages_apt_alt_srcs[@]}; do
  _pp "Adding $src"
  _run "sudo echo \"\\n$src\" >> /etc/apt/sources.list"
done


if [[ $debugging ]]; then
  exit
fi

# Don't really have to debug the rest

# pip
sudo curl http://python-distribute.org/distribute_setup.py | python
sudo curl https://raw.github.com/pypa/pip/master/contrib/get-pip.py | python
sudo pip install flake8 virtualenv

# Dotfiles
_pp "Getting dotfiles from $dotfiles_repo (branch: $dotfiles_branch)"
cd ~
git init
git remote add -t $dotfiles_branch -f origin $dotfiles_repo
git checkout $dotfiles_branch

_pp "Getting submodules from dotfiles repo"
git submodule update --init --force
git config status.showuntrackedfiles no
_pp_d

_pp "Making ZSH the default shell"
chsh -s /bin/zsh
_pp_d

# http://splatoperator.com/2012/02/dropbox-unable-to-monitor-filesystem/
_pp "Fixing notification settings for Dropbox"
echo "fs.inotify.max_user_watches = 99999999999" | sudo tee /etc/sysctl.d/20-dropbox-inotify.conf
sudo sysctl -p /etc/sysctl.d/20-dropbox-inotify.conf


# http://www.spotify.com/us/download/previews/
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 94558F59

_pp "Setting guake hotkey to $guake_hotkey"
gconftool-2 -t string -s /apps/guake/keybindings/global/show_hide "$guake_hotkey"
_pp_d

# I had to do this because tmux was looking for this folder
if [[ ! -d /private ]]; then
  sudo mkdir /private
  sudo ln -s /tmp /private/tmp
fi

# http://www.nongnu.org/autocutsel/ http://superuser.com/a/177541/147375
_pp "You can allow sharing of X11 and GTK's clipboard"
_pp "autocutsel &; autocutsel -s PRIMARY &"
_pp "An autostart script of this has been added to ~/.config/autostart/"

# TODO: add this to startup scripts automatically
# http://askubuntu.com/a/149972/91891
_pp "You can switching capslock and ctrl using this command:"
_pp "/usr/bin/setxkbmap -option \"ctrl:swapcaps\" && /usr/bin/setxkbmap -option \"ctrl:nocaps\""
_pp "An autostart script of this has been added to ~/.config/autostart/"

cd $dir_current
