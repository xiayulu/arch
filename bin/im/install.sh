#!/bin/bash

# install fonts
fonts=adobe-source-han-sans-cn-fonts
print_info "Installing fonts: $fonts..."
sudo pacman -Sy $fonts

# install im
print_info "Installing input method..."
sudo pacman -Sy fcitx5-im fcitx5-chinese-addons fcitx5-pinyin-zhwiki fcitx5-material-color

# config im
print_info "Config imput method at: $SYSTEM_ENV_FILE"
sudo cat <<EOF >>$SYSTEM_ENV_FILE
#GTK_IM_MODULE=fcitx
QT_IM_MODULE=fcitx
XMODIFIERS=@im=fcitx
INPUT_METHOD=fcitx
SDL_IM_MODULE=fcitx
GLFW_IM_MODULE=ibus
EOF

print_info "Enable fcitx at hyprland"

hypr_config="$HOME/.config/hypr/hyprland.conf"
echo 'exec-once=fcitx5 --replace -d' >>$hypr_config

print_ok "Config fonts and input method done."
print_warn "Run Fcitx5 Configuration to add input method."
print_warn "Use CTRL+SPACE to switch input method."
