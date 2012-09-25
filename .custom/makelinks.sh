#!/usr/bin/env zsh

#
# Creates symbolic links from input to the autoload directory
#

dir_custom=$HOME/.custom
dir_target=$dir_custom/$1
dir_autoload=$dir_custom/autoload

if [[ ! -d $dir_target ]]; then
  echo "$dir_target does not exist"
  exit 2
fi

find $dir_autoload -type l -delete

for script in $(find $dir_target -type f -name "*.zsh"); do
  echo "Creating link from $script"
  ln -s "$script" "$dir_autoload"
done

for dotfile in $(find $dir_target -name ".*"); do
  dotfile_name = `basename $dotfile`
  dotfile_home = $HOME/$dotfile_name
  if [[ -d $dotfile_home || -f "$dotfile_home" ]]; then
    echo "Moving $dotfile_home to $dotfile_home.backup"
    mv "$dotfile_home{,.backup}"
  fi
  echo "Created link from $dotfile to $dotfile_home"
  ln -s $dotfile $dotfile_home
done
