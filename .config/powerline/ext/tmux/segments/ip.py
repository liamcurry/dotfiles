# -*- coding: utf8 -*-
import urllib2


url = 'http://automation.whatismyip.com/n09230945.asp'


def external_ip():
    return u'ⓦ  ' + unicode(urllib2.urlopen(url).read().strip())
