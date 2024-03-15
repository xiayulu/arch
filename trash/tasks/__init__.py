import logging
import os
from typing import List
from subprocess import run as p_run, Popen, PIPE, STDOUT


class Task:
    name = "abstract task"
    description = "This is an abstract Task, you should inherit it."

    cache_dir = os.path.join(os.path.dirname(os.path.abspath(__file__)), "../.cache")
    config_dir = os.path.join(os.path.dirname(os.path.abspath(__file__)), "../.config")
    user_config_dir = os.path.join(os.path.expanduser("~"), ".config")

    packages = []
    aur_packages = []

    def _cmd_split(self, cmd: str) -> List[str]:
        return [*cmd.split()]

    def run(self, cmd: str, **kwargs):
        """
        Run some cmd using subprocess.run().
        """

        ret = p_run(self._cmd_split(cmd), stderr=STDOUT, text=True, **kwargs)
        if ret.returncode != 0:
            self.error(f"Running {cmd} Error:\n {ret.stdout}\n")
            ret.check_returncode()

    def install(self):
        """
        Install packages using `sudo pacman -Sy`
        and install aur_packages using `yay -S`
        """

        if len(self.packages) > 0:
            self.run(f"sudo pacman -Sy {' '.join(self.packages)}")

        if len(self.aur_packages) > 0:
            self.run(f"yay -S {' '.join(self.aur_packages)}")

    def mkdir(self, path: str, sudo=False):
        cmd = f"mkdir -p {path}"
        if sudo:
            cmd = "sudo " + cmd

        if not os.path.exists(path):
            self.run(cmd)

    def copy_file(self, src: str, dst: str, sudo=False):
        """
        Copy file: src ---> dst
        """

        cmd = f"cp {src} {dst}"
        if sudo:
            cmd = "sudo " + cmd
        self.run(cmd)

    def git_clone(self, remote_repo: str):
        self.run(f"git clone {remote_repo}", cwd=self.cache_dir)

    def append_config(self, config_file: str, lines: List[str], sudo=False):
        for line in lines:
            cmd = f'echo "{line}">> {config_file}'
            if sudo:
                cmd = "sudo " + cmd

            os.system(cmd)

    def error(self, msg: str):
        red = "\n\x1b[31;20m"
        reset = "\x1b[0m\n"
        print(red + "[Error] %(msg)s" % {"msg": msg} + reset)

    def ok(self, msg: str):
        green = "\n\x1b[32;20m"
        reset = "\x1b[0m\n"
        print(green + "[Ok] %(msg)s" % {"msg": msg} + reset)

    def warn(self, msg: str):
        yellow = "\n\x1b[33;20m"
        reset = "\x1b[0m\n"
        print(yellow + "[Ok] %(msg)s" % {"msg": msg} + reset)

    def info(self, msg: str):
        grey = "\n\x1b[38;20m"
        reset = "\x1b[0m\n"
        print(grey + "[Ok] %(msg)s" % {"msg": msg} + reset)

    def do(self):
        self.error("Do something awesome...")
