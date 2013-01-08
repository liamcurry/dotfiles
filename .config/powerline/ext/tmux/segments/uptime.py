# -*- coding: utf8 -*-


def uptime():

    with open('/proc/uptime', 'r') as f:
        seconds = float(f.readline().split()[0])
        minutes, seconds = divmod(seconds, 60)
        hours, minutes = divmod(minutes, 60)
        days, hours = divmod(hours, 24)
        return u'⇑ %02dd%02dh%02dm%02ds' % (days, hours, minutes, seconds)
