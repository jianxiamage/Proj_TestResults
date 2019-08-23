#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys  #引入模块
import os
import traceback
import ConfigParser

from get_GroupNum import *


ResultPath='/data-std/'
ResultIniFile='TestResults.ini'

def getResult(TestType,Platform,TestCase,NodeNum):
    
    ResultIniPath = ResultPath + str(TestType) + '/' + str(Platform) + '/' + ResultIniFile
    print(ResultIniPath)
    config = ConfigParser.ConfigParser()
    #print os.getcwd() #获取当前工作目录路径

    config.readfp(open(ResultIniPath))
    
    #根据测试用例名称找出其对应小组编号
    #Group_num=getGroupNumByName(TestType,TestCase)

    #sectionName='Group'+ str(Group_num)
    sectionName = str(TestCase)
    keyName = 'node_'+ str(NodeNum)
    resultStr=config.get(sectionName,keyName)

    #获取section的option值
    keyValue = config.get(sectionName,keyName)
 
    retCode=int(keyValue)
    return retCode


if __name__=='__main__':

  try:
  
      test_case_type = sys.argv[1]
      test_case_platform = sys.argv[2]
      test_case = sys.argv[3]
      node_num = sys.argv[4]
      
      #a = config.get(sectionName,valName)
      #getResult(test_case_type,test_case_platform,test_case,node_num)
  
  except Exception as E:
      #print('str(Exception):', str(Exception))
      print('str(e):', str(E))
      #print('repr(e):', repr(E))
      #print('traceback.print_exc(): ', traceback.print_exc())
