name='yay'

# install yay aur helper
yay -h /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo -e "$info[Info] $name already installed $reset"
else
    echo -e "$info[Info] Installing $yay $reset"
    mkdir .cache && cd .cache
    git clone https://aur.archlinux.org/yay-bin.git
    cd yay-bin && makepkg -si
    # clean
    cd ..
    rm -r .cache
fi

echo -e "$ok[Done] install $name done. $reset"
