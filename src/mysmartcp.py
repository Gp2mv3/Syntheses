#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Jul  9 17:48:56 2018

@author: Martin Braquet
"""

import os
import sys
import yaml   
            
def main():
    quadri = int(sys.argv[1])
    name = sys.argv[2]
    option = sys.argv[3]
    code = int(sys.argv[4])
    typ = sys.argv[5]
    with open(os.path.dirname(os.path.realpath(__file__)) + '/config.yml', 'r') as stream:
        document = yaml.load(stream)
        stream.close()
        
        abspath = document['output_base']
        cycle = document['clients'][0]['output']['parameters'][0]['parameters'][0]['mapping'][quadri]
        option_map = document['clients'][0]['output']['parameters'][0]['parameters'][1]['mapping'][option]
        titre = document['clients'][0]['output']['parameters'][0]['parameters'][5]['mapping'][name]
        if typ == 'exam' or typ == 'test':
            year = int(sys.argv[6])
            month = sys.argv[7]
            type_map = document['clients'][1]['output']['parameters'][1]['mapping'][typ]
            out_path = abspath + '/' + cycle + '/' + option_map + '/Q' + str(quadri) + '/L' + option + str(code) + ' - ' + titre + '/' + type_map + '/' + str(year) + '_' + month.title()
        else:
            type_map = document['clients'][0]['output']['parameters'][1]['mapping'][typ]
            out_path = abspath + '/' + cycle + '/' + option_map + '/Q' + str(quadri) + '/L' + option + str(code) + ' - ' + titre + '/' + type_map
    
    print(out_path)
            
if __name__ == "__main__":
    main()
