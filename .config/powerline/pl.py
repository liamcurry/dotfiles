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

side = sys.argv[1]
segments_all = pl.renderer.get_theme().get_segments()
segments_side = [segment for segment in segments_all if segment['side'] == side]

print(pl.renderer.render('n', segments=segments_side).encode('utf-8'))
