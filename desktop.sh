#!/bin/bash

# Exit if shit hits the fan
set -e
set -x

echo "[desktop.sh] cd to ~/suckless..."
mkdir -p $HOME/suckless
cd $HOME/suckless

echo "[desktop.sh] Clone the suckless..."
[ ! -d ./dwm ] && git clone https://git.suckless.org/dwm
[ ! -d ./dmenu ] && git clone https://git.suckless.org/dmenu
[ ! -d ./st ] && git clone https://git.suckless.org/st

echo "[desktop.sh] Symlink the config.h..."
if [ ! -L ./dwm/config.h ]; then
	[ -f ./dwm/config.h ] && rm ./dwm/config.h
	ln -s $HOME/dots/conf/dwm/dwm/config.h $HOME/suckless/dwm/config.h
fi
if [ ! -L ./st/config.h ]; then
	[ -f ./st/config.h ] && rm ./st/config.h
	ln -s $HOME/dots/conf/dwm/st/config.h $HOME/suckless/st/config.h
fi

echo "[desktop.sh] Make the suckless..."
cd $HOME/suckless/dwm
sudo make install clean
cd $HOME/suckless/dmenu
sudo make install clean
cd $HOME/suckless/st
sudo make install clean

echo "[desktop.sh] Symlink the .xinitrc & .Xresources..."
[ -f $HOME/.xinitrc ] && rm $HOME/.xinitrc
ln -s $HOME/dots/conf/dwm/xinitrc $HOME/.xinitrc
[ -f $HOME/.Xresources ] && rm $HOME/.Xresources
sudo echo 'Xft.dpi: 180
Xft.antialias: true' | sudo tee $HOME/.Xresources


