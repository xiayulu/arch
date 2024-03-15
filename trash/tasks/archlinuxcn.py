from . import Task


class Archlinuxcn(Task):
    name = "archlinuxcn"
    description = "Config archlinuxcn"

    def add_mirror(self):
        lines = [
            "[archlinuxcn]",
            "Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch",
        ]
        with open("/etc/pacman.conf", "a") as f:
            f.write("\n" + "\n".join(lines) + "\n")

    def add_key(self):
        self.run(["sudo", "pacman-key", "--lsign-key", "farseerfc@archlinux.org"])
        self.run(["sudo", "pacman", "-Sy", "archlinuxcn-keyring"])

    def do(self):
        self.add_mirror()
        self.add_key()
