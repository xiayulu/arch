#!/bin/bash

name=archlinuxcn
pacman_conf=/etc/pacman.conf
my_pacman_conf="archlinuxcn/pacman/pacman.conf"

# config arlinuxcn mirror
res=$(grep -c $name $pacman_conf)
if file_contain $pacman_conf $name; then
    print_info "$name is already in $pacman_conf"
else
    print_info "Copying $my_pacman_conf ---> $pacman_conf ..."
    print_warn "This will overwrite $pacman_conf"
    sudo cp $my_pacman_conf $pacman_conf
fi

# config GPG key
key_pkg=archlinuxcn-keyring
if pkg_installed $key_pkg; then
    print_info "$key_pkg has already installed"
else
    print_info "Installing $key_pkg"
    sudo pacman-key --lsign-key "farseerfc@archlinux.org"
    sudo pacman -Sy $key_pkg
fi

print_ok "Config $name done."
