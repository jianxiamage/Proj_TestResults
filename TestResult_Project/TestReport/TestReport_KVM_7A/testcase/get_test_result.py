#!/usr/bin/env python
# -*- coding: utf-8 -*-

import commands
import sys  #引入模块
import os
import traceback
import ConfigParser

#from get_GroupNum import *

#ResultIniPath='/data/OS/7A/TestResults.ini'
def getResult(TestCase,NodeNum):

    resultIniFile = 'testResultIni_path.txt'
    #print('********************************************')
    #print os.getcwd() #获取当前工作目录路径
    #print os.path.split( os.path.realpath( sys.argv[0] ) )
    curPath = os.path.split(os.path.realpath(__file__))[0]
    #print os.path.split(os.path.realpath(__file__))[0]
    #print('********************************************')
    ini_resultPath = os.path.join(curPath,resultIniFile )
    cmdInput = 'cat ' + str(ini_resultPath)
    retCode,output = commands.getstatusoutput(cmdInput)
    #print  retCode
    #print  output
    
    ResultIniPath = str(output)   

    config = ConfigParser.ConfigParser()
    config.readfp(open(ResultIniPath))
    #Group_num=getGroupNumByName(TestCase)
    sectionName = str(TestCase)
    keyName = 'node_'+ str(NodeNum)
    resultStr=config.get(sectionName,keyName)
    retCode=int(resultStr)
    #print retCode
    return retCode


if __name__=='__main__':

  try:
  
      test_case = sys.argv[1]
      node_num = sys.argv[2]
      
      #a = config.get(sectionName,valName)
      result_code=getResult(test_case,node_num)
      retCode=result_code
      print retCode
  
  except Exception as E:
      #print('str(Exception):', str(Exception))
      print('str(e):', str(E))
      #print('repr(e):', repr(E))
      #print('traceback.print_exc(): ', traceback.print_exc())
