#!/bin/bash

name=tofi
my_config_dir="tofi/.config"
user_config_dir="$HOME/.config/tofi"

print_info "Installing $name ..."
yay -S $name

print_info "Copy config files..."
cp -r "$my_config_dir/" "$user_config_dir"

print_ok "Install $name done."
print_warn "You should change your hyprland key bind by hand"
