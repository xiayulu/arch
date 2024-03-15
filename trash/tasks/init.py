from . import Task


class InitTask(Task):
    def do(self):
        self.run("sudo pacman -Syyu")
        self.mkdir(self.cache_dir)
