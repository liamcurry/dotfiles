# -*- coding: utf8 -*-
import json
import urllib2
import time


conditions = {
    u'〇': ['clear', 'fair', 'cold'],
    u'⚑': ['windy', 'fair/windy'],
    u'☔': [
        'rain', 'mixed rain and snow', 'mixed rain and sleet',
        'freezing drizzle', 'drizzle', 'freezing rain', 'showers',
        'mixed rain and hail', 'scattered showers', 'isolated thundershowers',
        'thundershowers', 'light rain with thunder', 'light rain'
    ],
    u'☁': [
        'cloudy', 'mostly cloudy', 'partly cloudy', 'partly cloudy/windy'
    ],
    u'❅': [
        'snow', 'mixed snow and sleet', 'snow flurries', 'light snow showers',
        'blowing snow', 'sleet', 'hail', 'heavy snow', 'snow showers',
        'scattered snow showers', 'light snow'
    ],
    u'☈': [
        'tornado', 'tropical storm', 'hurricane', 'severe thunderstorms',
        'thunderstorms', 'isolated thunderstorms', 'scattered thunderstorms'
    ],
    u'〰': ['dust', 'foggy', 'fog', 'haze', 'smoky', 'blustery', 'mist'],
    u'☼': ['sunny', 'hot'],
}


def forecast():
    url = ('http://query.yahooapis.com/v1/public/yql?q=select%20item%20from%20'
           'weather.forecast%20where%20location%3D%2221122%22&format=json')
    response = json.loads(urllib2.urlopen(url).read())
    condition = response['query']['results']['channel']['item']['condition']
    text = condition['text'].lower()
    hour = time.localtime().tm_hour
    icon = u'〇'

    if hour > 22 or hour < 5 and (text in conditions[u'〇'] or
                                  text in conditions[u'☼']):
        icon = u'☾'
    else:
        for key, matches in conditions.items():
            if text in matches:
                icon = key
                break

    return u'{0} {1}°'.format(icon, condition['temp'])
