#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys  #引入模块
import traceback
import ConfigParser

TestcasePath='/data/'
def getGroupNumByName(TestType,keyName):

    GroupIniFile='TestcaseGroup_' + TestType +'.ini'
    TestcaseGroupPath = TestcasePath + str(TestType) +  '/' + GroupIniFile
    config = ConfigParser.ConfigParser()
    config.readfp(open(TestcaseGroupPath))
    sectionName='GroupNum'
    Num=config.get(sectionName,keyName)
    return Num


if __name__=='__main__':

  try:
  
      test_type = sys.argv[1]
      test_case = sys.argv[2]
      
      #a = config.get(sectionName,valName)
      GroupNum=getGroupNumByName(test_type,test_case)
      retCode=GroupNum
      print retCode
  
  except Exception as E:
      #print('str(Exception):', str(Exception))
      print('str(e):', str(E))
      #print('repr(e):', repr(E))
      #print('traceback.print_exc(): ', traceback.print_exc())
