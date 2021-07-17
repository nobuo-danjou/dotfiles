#!/bin/sh
DOTPATH="$(pwd)"
for f in .??*
do
    [ "$f" == ".git" ] && continue
    [ "$f" == ".DS_Store" ] && continue
    ln -s $DOTPATH/$f $HOME/$f
done
