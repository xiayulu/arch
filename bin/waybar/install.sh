#!/bin/bash

name=waybar
my_config_dir="waybar/.config"
user_config_dir="$HOME/.config/waybar"

print_info "Installing $name ..."
yay -S $name

print_info "Copy config files..."
cp -r "$my_config_dir/" "$user_config_dir"

hypr_config="$HOME/.config/hypr/hyprland.conf"
print_info "Config $name at hyprland.conf"
cat <<EOF >>$hypr_config
# start waybar
exec-once=waybar
EOF

print_ok "Install $name done."
