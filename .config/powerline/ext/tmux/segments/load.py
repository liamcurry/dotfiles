import os
import multiprocessing


def system_load():
    averages = os.getloadavg()
    normalized = averages[1] / multiprocessing.cpu_count()
    if normalized < 1:
        gradient = 'system_load_good'
    elif normalized < 2:
        gradient = 'system_load_bad'
    else:
        gradient = 'system_load_ugly'
    return {
        'contents': str(averages)[1:-1],
        'highlight': [gradient, 'system_load']
    }
