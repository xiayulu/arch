#!/bin/bash

my_config_dir="hyprland/.config"
my_config_file="$my_config_dir/hyprland.conf"

user_config_dir="$HOME/.config/hypr"
user_config_file="$user_config_dir/hyprland.conf"

print_info "Copying config file: $my_config_file ---> $user_config_file"
cp $my_config_file $user_config_file

print_info "install 4k utils"

if pkg_installed xorg-xwayland-hidpi-xprop; then
    print_info "4k utils has installed"
else
    yay -S xorg-xwayland-hidpi-xprop wlroots-hidpi-xprop-git hyprland-hidpi-xprop-git xorg-xrdb
fi

print_ok "Config hyprland done."
