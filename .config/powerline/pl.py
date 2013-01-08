#!/usr/bin/env python
# -*- coding: utf-8 -*-
'''Powerline tmux statusline example.

Run with `tmux -f tmux.conf`.
'''

import os
import sys
sys.path.append(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))

from powerline.core import Powerline

pl = Powerline('tmux')
left, right = pl.renderer.get_theme().get_segments()

segments = [right]
if sys.argv[1] == 'left':
    segments = [left]
print(pl.renderer.render('n', segments=segments).encode('utf-8'))
