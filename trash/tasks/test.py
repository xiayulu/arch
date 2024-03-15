from . import Task
from os import path


class TestTask(Task):
    name = "test"
    description = """
    A Test Task, 
    Mainly Used for testing some functions.
    """

    def test_show_dirs(self):
        print(self.cache_dir)
        print(self.config_dir)
        print(self.user_config_dir)

    def test_mkdir(self):
        self.mkdir(path.join(self.user_config_dir, "hello"))

    def test_msg_print(self):
        self.error("Error message")
        self.ok("ok message")
        self.info("normal info")
        self.warn("some warning message")

    def test_copy_file(self):
        src = path.join(self.config_dir, "test/hello.txt")
        dst = "/tmp"
        self.copy_file(src, dst)

    def test_append_config(self):
        lines = ["the", "quick", "fox"]
        file = "/tmp/hello.txt"
        self.append_config(file, lines, sudo=True)

    def do(self):
        self.test_append_config()
