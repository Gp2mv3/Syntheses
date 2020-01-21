#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on 24/08/2018

@author: Martin Braquet
"""

import os
import sys
import yaml   
            
# Absolute path to the config file
if len(sys.argv) == 3:
    CONFIG_FILE_NAME = sys.argv[1] + 'src/config.yml' 
    name = sys.argv[2]
else:
    CONFIG_FILE_NAME = 'src/config.yml' 
    name = sys.argv[1]
    
with open(CONFIG_FILE_NAME, 'r') as stream:
    document = yaml.load(stream)
    stream.close()
    try:
        titre = document['name'][name]
    except KeyError:
        titre = name

print(titre.encode('utf-8'))