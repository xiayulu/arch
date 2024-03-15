name='yay'

# install yay aur helper
if pkg_installed $name; then
    print_info "$name  has already installed"
else
    print_info "Installing $name"
    mkdir .cache && cd .cache
    git clone https://aur.archlinux.org/yay-bin.git
    cd yay-bin && makepkg -si
    # clean
    cd ..
    rm -rf .cache
fi

print_ok "Install $name done."
