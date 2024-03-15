#!/bin/bash

name=mako
my_config_dir="mako/.config"
user_config_dir="$HOME/.config/mako"

print_info "Installing $name ..."
yay -S $name

print_info "Copy config files..."
cp -r "$my_config_dir/" "$user_config_dir"

print_ok "Install $name done."
print_warn "You can test $name by run: notify-send 'Hello world!' 'This is an example notification.' -u normal"
