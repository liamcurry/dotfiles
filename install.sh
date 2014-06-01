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
