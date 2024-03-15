#!/bin/bash

my_config_dir="hyprland/.config"
my_config_file="$my_config_dir/hyprland.conf"

user_config_dir="$HOME/.config/hypr"
user_config_file="$user_config_dir/hyprland.conf"

print_info "install 4k utils"
yay -S xorg-xwayland-hidpi-xprop wlroots-hidpi-xprop-git hyprland-hidpi-xprop-git xorg-xrdb

print_info "Copying config file: $my_config_file ---> $user_config_file"
copy $my_config_file $user_config_file

print_ok "Config hyprland done."
