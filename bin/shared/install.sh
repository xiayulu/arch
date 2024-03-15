#!/bin/bash

# set -e # if any excerption, script will exit

############ Global variables ###################
# common dirs
SERVICE_ROOT_DIR="/etc/systemd/system"
SYSTEM_ENV_FILE="/etc/environment"

# common cmds
AUR_HELPER="yay"

############ End Global vars #####################

print_error() {
    local msg=$1
    local red="\033[0;31m"
    local reset="\033[0m"
    echo -e "$red[ERROR] $msg $reset"
}

print_ok() {
    local msg=$1
    local green="\033[0;32m"
    local reset="\033[0m"
    echo -e "$green[OK] $msg $reset"
}

print_warn() {
    local msg=$1
    local yellow="\033[1;33m"
    local reset="\033[0m"
    echo -e "$yellow[WARNING] $msg $reset"
}

print_info() {
    local msg=$1
    local white="\033[0;38m"
    local reset="\033[0m"
    echo -e "$white[INFO] $msg $reset"
}

service_ctl() {
    local service_name=$1

    if [[ $(systemctl list-units --all -t service --full --no-legend "${service_name}.service" | sed 's/^\s*//g' | cut -f1 -d' ') == "${service_name}.service" ]]; then
        print_ok "$service_name service is already enabled, restarting..."
        sudo systemctl restart ${service_name}.service
    else
        print_info "$service_name service is not running, enabling..."
        sudo systemctl enable ${service_name}.service
        sudo systemctl start ${service_name}.service
        print_info "$service_name service enabled, and running..."
    fi
}

pkg_installed() {
    local PkgIn=$1

    if pacman -Qi $PkgIn &>/dev/null; then
        #echo "${PkgIn} is already installed..."
        return 0
    else
        #echo "${PkgIn} is not installed..."
        return 1
    fi
}

file_contain() {
    local file=$1
    local pattern=$2

    local count=$(grep -c $pattern $$file)

    if [ "$count" == "0" ]; then
        #echo "$file not contain $pattern"
        return 1
    else
        #echo "$file contain $pattern"
        return 0
    fi
}

pkg_available() {
    local PkgIn=$1

    if pacman -Si $PkgIn &>/dev/null; then
        #echo "${PkgIn} available in arch repo..."
        return 0
    else
        #echo "${PkgIn} not available in arch repo..."
        return 1
    fi
}

check_aur_helper() {
    if pkg_installed yay; then
        AUR_HELPER="yay"
    elif pkg_installed paru; then
        AUR_HELPER="paru"
    fi
}

aur_available() {
    local PkgIn=$1
    check_aur_helper

    if $AUR_HELPER -Si $PkgIn &>/dev/null; then
        #echo "${PkgIn} available in aur repo..."
        return 0
    else
        #echo "aur helper is not installed..."
        return 1
    fi
}

nvidia_detect() {
    if [ $(lspci -k | grep -A 2 -E "(VGA|3D)" | grep -i nvidia | wc -l) -gt 0 ]; then
        #echo "nvidia card detected..."
        return 0
    else
        #echo "nvidia card not detected..."
        return 1
    fi
}

prompt_timer() {
    local timsec=$1
    local msg=$2
    local pread=""
    while [[ $timsec -ge 0 ]]; do
        echo -ne "\033[0K\r${msg} (${timsec}s) : "
        read -t 1 -n 1 -s promptIn
        [ $? -eq 0 ] && break
        ((timsec--))
    done
    export promptIn
    echo ${promptIn}
}
