from . import Task
from os import path


class Clash(Task):
    name = "clash"
    description = "Config Clash"

    aur_packages = ["clash"]

    def do(self):
        # install clash from aur
        self.install()

        # make ~/.config/clash
        clash_config_dir = path.join(self.user_config_dir, "clash/")
        self.mkdir(clash_config_dir)

        # copy yaml
        yaml = path.join(self.config_dir, "clash/config.yaml")
        self.copy_file(yaml, clash_config_dir)

        # copy mmdb
        mmdb = path.join(self.config_dir, "clash/Country.mmdb")
        self.copy_file(mmdb, clash_config_dir)

        # config clash service
        service = path.join(self.config_dir, "clash/clash.service")
        self.copy_file(service, "/etc/systemd/system/")
        cmd = ["sudo", "systemctl", "enable", "clash.service", "--now"]
        self.run(cmd)

        # add env vars
        lines = [
            "http_proxy=http://127.0.0.1:7890",
            "https_proxy=http://127.0.0.1:7890",
            "socks_proxy=http://127.0.0.1:7891",
            'no_proxy="localhost, 127.0.0.1"',
        ]
        self.append_config("/etc/environment", lines)

        # keep sudoers env
        proxy = path.join(self.config_dir, "clash/proxy")
        self.copy_file(proxy, "/etc/sudoers.d/")
