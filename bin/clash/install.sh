#!/bin/bash
name='clash'

default_clash_dir="clash/.config"
default_yaml="$default_clash_dir/config.yaml"
default_mmdb="$default_clash_dir/Country.mmdb"

# makesure has default config file
if [ ! -f $default_yaml ]; then
    print_error "$default_yaml not found, you should download it from your subscription link and rename to $default_yaml"
    exit 1
fi

# install clash
if pkg_installed clash; then
    print_ok "$name has already installed"
else
    yay -S $name
fi

# config clash
user_clash_dir="$HOME/.config/clash"
user_yaml="$user_clash_dir/config.yaml"
user_mmdb="$user_clash_dir/Country.mmdb"

copy_clash_config() {
    print_info "Copying $default_yaml --> $user_yaml ..."
    mkdir -p $user_clash_dir
    cp $default_yaml $user_yaml
    cp $default_mmdb $user_mmdb
}

if [ -f $user_yaml ]; then
    # if has content
    res=$(grep -c "name" $user_yaml)
    if [ "$res" == "0" ]; then
        copy_clash_config
    else
        print_info "$user_yaml already exists."
    fi
else
    copy_clash_config
fi

# config clash.service
service_file="$default_clash_dir/clash.service"
print_info "$Copying $service_file --> $SERVICE_ROOT_DIR ..."
sudo cp $service_file $SERVICE_ROOT_DIR
service_ctl $name

# config env vars
print_info "Configing proxy env vars at: $SYSTEM_ENV_FILE ..."
sudo echo 'http_proxy=http://127.0.0.1:7890' >>$SYSTEM_ENV_FILE
sudo echo 'https_proxy=http://127.0.0.1:7890' >>$SYSTEM_ENV_FILE
sudo echo 'socks_proxy=http://127.0.0.1:7891' >>$SYSTEM_ENV_FILE
sudo echo 'no_proxy="localhost, 127.0.0.1"' >>$SYSTEM_ENV_FILE

print_info "Configing sudoers env file"
sudo_keep_proxy="$default_clash_dir/proxy"
sudo cp $sudo_keep_proxy "/etc/sudoers.d/"

# done
print_ok "Install $name done."
