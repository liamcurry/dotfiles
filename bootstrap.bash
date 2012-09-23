#!/usr/bin/env bash

dotfiles_repo="git://github.com/liamcurry/dotfiles.git"
dotfiles_branch="barebones"

dir_current=$PWD
dir_downloads="~/Downloads"

guake_hotkey="<Control>semicolon"

# Packages to be installed via apt
packages_apt=(
  curl
  vim
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

function please_print {
  echo "--- $1"
}

function please_hr {
  echo "--------------------------------------"
}

function please_done {
  please_print "Done! Moving on..."
  please_hr
}

function please_debug {
  please_print "*** DEBUGGING: $1"
}

function run_or_debug {
  if [[ $debugging ]]; then
<<<<<<< HEAD
    please_debug "Would have ran: $1"
=======
    please_debug "$1"
>>>>>>> Adding ubuntu stuff; removed dumb aliases and added useful ones
  else
    `$1`
  fi
}

please_hr
please_hr
please_hr
<<<<<<< HEAD

please_print "Allowing you to run sudo without a password"
run_or_debug "sudo echo \"\\n$USER ALL=NOPASSWD: ALL\" >> /etc/sudoers"
please_done

=======
>>>>>>> Adding ubuntu stuff; removed dumb aliases and added useful ones
please_print "Installing apt-get packages..."
cmd_apt="sudo apt-get install -y ${packages_apt[@]}"
if [[ $debugging ]]; then
  please_debug "$cmd_apt"
else
  `$cmd_apt`
fi
please_done

please_print "Downloading debian packages..."
run_or_debug "mkdir -p $dir_downloads && cd $dir_downloads"
run_or_debug "wget ${packages_deb[@]} ${packages_tar[@]}"
please_done


please_print "Installing debian packages..."
for package in ${packages_deb[@]}; do
  please_print "Installing $package_filename"
  package_filename="${package##*/}"
  package_filename="${package_filename%%\?*}"
  sudo dpkg -i "$package_filename"
done
please_done

# Extract and install tar packages
for package in ${packages_tar[*]}; do
  please_print "Installing $package_filename"
  package_filename="${package##*/}"
  package_filename="${package_filename%%\?*}"
  package_basename="${package_filename%*.tar.gz}"
  run_or_debug "tar -xf $package_filename"
  run_or_debug "cd $package_basename"
  run_or_debug "./configure && make && sudo make install"
done

# Add sources for the package manager
please_print "Adding sources to /etc/apt/sources.list"
for src in ${packages_apt_alt_srcs[@]}; do
  please_print "Adding $src"
<<<<<<< HEAD
  run_or_debug "sudo echo \"\\n$src\" >> /etc/apt/sources.list"
=======
  run_or_debug "sudo echo \"\n$src\" >> /etc/apt/sources.list"
>>>>>>> Adding ubuntu stuff; removed dumb aliases and added useful ones
done


if [[ $debugging ]]; then
  exit
fi

# Don't really have to debug the rest

# Dotfiles
please_print "Getting dotfiles from $dotfiles_repo (branch: $dotfiles_branch)"
cd ~
git init
git remote add -t $dotfiles_branch -f origin $dotfiles_repo
git checkout $dotfiles_branch

please_print "Getting submodules from dotfiles repo"
git submodule update --init --force
git config status.showuntrackedfiles no

please_print "Making ZSH the default shell"
chsh -s /bin/zsh

# http://splatoperator.com/2012/02/dropbox-unable-to-monitor-filesystem/
please_print "Fixing notification settings for Dropbox"
echo "fs.inotify.max_user_watches = 99999999999" | sudo tee /etc/sysctl.d/20-dropbox-inotify.conf
sudo sysctl -p /etc/sysctl.d/20-dropbox-inotify.conf


# http://www.spotify.com/us/download/previews/
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 94558F59

please_print "Setting guake hotkey to $guake_hotkey"
gconftool-2 -t string -s /apps/guake/keybindings/global/show_hide "$guake_hotkey"
please_done

# I had to do this because tmux was looking for this folder
if [[ ! -d /private ]]; then
  sudo mkdir /private
  sudo ln -s /tmp /private/tmp
fi

# http://www.nongnu.org/autocutsel/ http://superuser.com/a/177541/147375
please_print "You can allow sharing of X11 and GTK's clipboard"
please_print "autocutsel &; autocutsel -s PRIMARY &"
please_print "An autostart script of this has been added to ~/.config/autostart/"

# TODO: add this to startup scripts automatically
# http://askubuntu.com/a/149972/91891
please_print "You can switching capslock and ctrl using this command:"
please_print "/usr/bin/setxkbmap -option \"ctrl:swapcaps\" && /usr/bin/setxkbmap -option \"ctrl:nocaps\""
please_print "An autostart script of this has been added to ~/.config/autostart/"

cd $dir_current
