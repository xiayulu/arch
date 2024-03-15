from . import Task
from os import path


class YaY(Task):
    name = "yay"
    description = "install yay"

    def do(self):
        self.git_clone("https://aur.archlinux.org/yay-bin.git")
        cmd = ["makepkg", "-si"]
        self.run(cmd, cwd=path.join(self.cache_dir, "yay-bin"))
