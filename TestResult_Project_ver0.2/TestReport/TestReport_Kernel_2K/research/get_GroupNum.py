#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys  #引入模块
import traceback
import ConfigParser

try:

    Testcase = sys.argv[1]
    
    config = ConfigParser.ConfigParser()
    config.readfp(open('TestcaseGroup.ini'))
    
    sectionName='GroupNum'
    valName=Testcase
    a = config.get(sectionName,valName)
    print a


except Exception as E:
    #print('str(Exception):', str(Exception))
    print('str(e):', str(E))
    #print('repr(e):', repr(E))
    #print('traceback.print_exc(): ', traceback.print_exc())
