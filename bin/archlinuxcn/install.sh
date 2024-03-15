#!/bin/bash

name=archlinuxcn
pacman_conf=/etc/pacman.conf

# config arlinuxcn mirror
res=$(grep -c $name $pacman_conf)
if [ "$res" == "0" ]; then
    echo -e "$info[Info] Config /etc/pacman.conf $reset"
    echo -e "$warn[Warn] This will overwrite $pacman_conf $reset"
    sudo cp ./pacman/pacman.conf $pacman_conf
else
    echo -e "$info[Info] $name is already in $pacman_conf $reset"
fi

# config GPG key
key_pkg=archlinuxcn-keyring
res=$(pacman -Qi $key_pkg)
if [[ "error" =~ $res ]]; then
    echo -e "$info[Info] Installing $key_pkg $reset"
    sudo pacman-key --lsign-key "farseerfc@archlinux.org"
    sudo pacman -Sy $key_pkg
else
    echo -e "$info[Info] $key_pkg already installed $reset"
fi
echo -e "$ok[Done] config $name done. $reset"
