#!/bin/bash

name=clipboard

clipboard_pkg=cliphist
print_info "Installing $clipboard_pkg clipboard for clipboard manager..."
yay -S $clipboard_pkg

print_ok "Install $clipboard_pkg done."
print_warn "You should change config at your hyprland.conf"
