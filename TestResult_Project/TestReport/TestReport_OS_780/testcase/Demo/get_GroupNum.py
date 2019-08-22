#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys  #引入模块
import traceback
import ConfigParser

TestcaseGroupPath='/data/TestcaseGroup.ini'
def getGroupNumByName(keyName):
    config = ConfigParser.ConfigParser()
    config.readfp(open(TestcaseGroupPath))
    sectionName='GroupNum'
    Num=config.get(sectionName,keyName)
    return Num


if __name__=='__main__':

  try:
  
      testCase = sys.argv[1]
      
      #a = config.get(sectionName,valName)
      GroupNum=getGroupNumByName(testCase)
      retCode=GroupNum
      print retCode
  
  except Exception as E:
      #print('str(Exception):', str(Exception))
      print('str(e):', str(E))
      #print('repr(e):', repr(E))
      #print('traceback.print_exc(): ', traceback.print_exc())
