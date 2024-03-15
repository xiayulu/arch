from tasks.test import TestTask
from tasks.archlinuxcn import Archlinuxcn
from tasks.clash import Clash
from tasks.init import InitTask
import getpass


def main():

    tasks = [
        TestTask(),
        # InitTask(),
        # Archlinuxcn(),
        # Clash(),
    ]
    for t in tasks:
        t.do()


if __name__ == "__main__":
    main()
