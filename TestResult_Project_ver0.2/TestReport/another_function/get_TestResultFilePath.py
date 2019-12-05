#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys  #引入模块
import os
import traceback
import ConfigParser

def getIniPath(sectionName,keyName):

    IniPath='/data/TestResultFilePath.ini'
    config = ConfigParser.ConfigParser()
    config.readfp(open(IniPath))

    keyValue = config.get(sectionName,keyName)
    return keyValue


if __name__=='__main__':

  try:
  
      test_type = sys.argv[1]
      test_plat = sys.argv[2]
      
      iniFilePath = getIniPath(test_type,test_plat)
      print iniFilePath
  
  except Exception as E:
      #print('str(Exception):', str(Exception))
      print('str(e):', str(E))
      #print('repr(e):', repr(E))
      #print('traceback.print_exc(): ', traceback.print_exc())
