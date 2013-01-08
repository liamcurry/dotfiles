# -*- coding: utf8 -*-


def uptime():

    try:
        seconds = float(open('/proc/uptime', 'r').readline().split()[0])
        minutes, seconds = divmod(seconds, 60)
        hours, minutes = divmod(minutes, 60)
        days, hours = divmod(hours, 24)
        return u'⇑ %02dd%02dh%02dm%02ds' % (days, hours, minutes, seconds)
    except IOError:
        return u'⇑ ???'
