#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys  #引入模块
import os
import traceback
import ConfigParser

from get_GroupNum import *

#getGroupNumByName
ResultIniPath='/data/TestResults.ini'
def setResult(TestCase,NodeNum,keyValue):

    config = ConfigParser.ConfigParser()
    #print os.getcwd() #获取当前工作目录路径

    config.readfp(open(ResultIniPath))
    Group_num=getGroupNumByName(TestCase)
    sectionName='Group'+ str(Group_num)
    keyName='ip_'+ str(NodeNum)
    resultStr=config.get(sectionName,keyName)
    tmp='The old value is:'+resultStr
    print tmp
    #更新指定section的option值
    config.set(sectionName,keyName,keyValue)
 
    #保存到配置文件
    config.write(open(ResultIniPath,'w'))

    #retCode=int(resultStr)
    #return retCode


if __name__=='__main__':

  try:
  
      test_case = sys.argv[1]
      node_num = sys.argv[2]
      test_retcode = sys.argv[3]
      
      #a = config.get(sectionName,valName)
      setResult(test_case,node_num,test_retcode)
  
  except Exception as E:
      #print('str(Exception):', str(Exception))
      print('str(e):', str(E))
      #print('repr(e):', repr(E))
      #print('traceback.print_exc(): ', traceback.print_exc())
