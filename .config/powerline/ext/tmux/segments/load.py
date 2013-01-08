import os


def system_load():
    return str(os.getloadavg())[1:-1]
