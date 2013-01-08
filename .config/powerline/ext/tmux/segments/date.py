from datetime import datetime


now = datetime.now()


def day():
    return now.strftime('%a')


def date():
    return now.strftime('%Y-%m-%d')


def time():
    return now.strftime('%H:%M')
