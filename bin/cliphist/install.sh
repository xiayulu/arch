#!/bin/bash

name=cliphist

print_info "Installing $name as clipboard manager..."
yay -S $name

print_ok "Install $name done."
print_warn "You should change config at your hyprland.conf"
