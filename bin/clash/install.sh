#!/bin/bash
name='clash'

my_clash_dir="clash/.config"
my_yaml="$my_clash_dir/config.yaml"
my_mmdb="$my_clash_dir/Country.mmdb"

# makesure has default config file
if [ ! -f $my_yaml ]; then
    print_error "$my_yaml not found, you should download it from your subscription link and rename to $my_yaml"
    exit 1
fi

# install clash
if pkg_installed clash; then
    print_ok "$name has already installed"
else
    yay -S $name
fi

# run clash
clash

# config clash
user_clash_dir="$HOME/.config/clash"
user_yaml="$user_clash_dir/config.yaml"
user_mmdb="$user_clash_dir/Country.mmdb"

copy_clash_config() {
    print_info "Copying $my_yaml --> $user_yaml ..."
    mkdir -p $user_clash_dir
    cp $my_yaml $user_yaml
    # cp $my_mmdb $user_mmdb
}

copy_clash_config

# config clash.service
service_file="$my_clash_dir/clash.service"
print_info "$Copying $service_file --> $SERVICE_ROOT_DIR ..."
sudo cp $service_file $SERVICE_ROOT_DIR
service_ctl $name

# config env vars
print_info "Configing proxy env vars at: $SYSTEM_ENV_FILE ..."

sudo cp "$my_clash_dir/environment" $SYSTEM_ENV_FILE


print_info "Configing sudoers env file"
sudo_keep_proxy="$my_clash_dir/proxy"
sudo cp $sudo_keep_proxy "/etc/sudoers.d/"

# done
print_ok "Install $name done."
