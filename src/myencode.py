#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Apr 11 10:31:33 2020

@author: Martin Braquet
"""

import sys
        
if sys.platform.startswith('win32'):
    print(sys.argv[1].encode("latin-1").decode("utf-8"))
else:
    print(sys.argv[1])
