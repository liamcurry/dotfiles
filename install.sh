#!/usr/bin/env bash

DIR=`pwd`

for f in .*; do
    if [ ! -f ~/$f -a ! -d ~/$f ]; then
        echo "Processing file $f"
        ln -s $DIR/$f ~/$f
    else
        echo "~/$f already exists, skipping..."
    fi
done

command_exists () {
  type "$1" &> /dev/null ;
}

if command_exists apm; then
  apm install --packages-file ~/.atom/package-list.txt
fi
