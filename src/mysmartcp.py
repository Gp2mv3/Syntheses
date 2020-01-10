#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Jul  9 17:48:56 2018

@author: Martin Braquet
"""

import os
import sys
import yaml   
            
with open(os.path.dirname(os.path.realpath(__file__)) + '/../compilation.yml', 'r') as stream:
    document = yaml.load(stream)
    stream.close()
    abspath = document['output_base']
    
with open(os.path.dirname(os.path.realpath(__file__)) + '/config.yml', 'r') as stream:
    document = yaml.load(stream)
    stream.close()
    
    a = document["type"]
    
    quadri = int(sys.argv[1])
    
    if quadri == -1:
        print(abspath)
    else:
        name = sys.argv[2]
        option = sys.argv[3]
        code = int(sys.argv[4])
        typ = sys.argv[5]
    
        titre = document['name'][name]
        type_map = document['type'][typ]
        cycle = document['quadri'][quadri]
        
        option_map = document['option'][option]
        if option_map == 'MAT' and quadri < 7:
        	option_map = 'MAP'
        elif option_map == 'PHYS' and quadri < 7:
        	option_map = 'Mineures externes'
        
        if typ == 'exam' or typ == 'test':
            year = int(sys.argv[6])
            month = sys.argv[7]
            out_path = abspath + '/' + cycle + '/' + option_map + '/Q' + str(quadri) + '/L' + option + str(code) \
                        + ' - ' + titre + '/' + type_map + '/' + str(year) + '_' + month.title()
        else:
            out_path = abspath + '/' + cycle + '/' + option_map + '/Q' + str(quadri) + '/L' + option + str(code) \
                        + ' - ' + titre + '/' + type_map
        
        print(out_path)