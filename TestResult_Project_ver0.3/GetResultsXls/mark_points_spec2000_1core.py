#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys  #引入模块
import os
import traceback
import ConfigParser

#防止自动将ini文件中的键名转换成小写
class myconf(ConfigParser.ConfigParser):
    def __init__(self,defaults=None):
        ConfigParser.ConfigParser.__init__(self,defaults=None)
    def optionxform(self, optionstr):
        return optionstr

#-------------------------------------------------
#存在一个测试项含有多个测试结果文件的情况
#例如spec2000测试，无论单核测试还是多核测试均含有浮点和整型两种文件
#因此，相比只生成一个结果文件的测试项(例如iozone)要多加一个类型参数
#-------------------------------------------------
ResultPath='/data/'
detailDir='Detail'
PointsPath='Points_Files'
#global sectionName
#sectionName='spec2000-1core-'

def setPoint(TestType,Platform,TestCase,NodeNum,keyName,keyValue,mode):
    
    sectionName='spec2000-1core-'
    if mode == 'CFP':            
        sectionName = str(sectionName) + 'CFP'
    elif mode == 'CINT':
        sectionName = str(sectionName) + 'CINT'
    else:
        print 'not support the mode'
        return 1
     
    ResultIniPath = ResultPath + str(TestType) + '/' + str(Platform) + '/' + str(detailDir) + '/' + str(TestCase) + '/' + str(PointsPath) + '/' + str(TestCase) + '_' +  str(mode) + '_' + str(NodeNum) + '.ini'

    #print('-----------------------------------')
    #print(ResultIniPath)
    #print('-----------------------------------')
    config = myconf()
    #print os.getcwd() #获取当前工作目录路径

    config.readfp(open(ResultIniPath))
    
    #根据测试用例名称找出其对应小组编号
    #Group_num=getGroupNumByName(TestType,TestCase)

    keyName = str(keyName)
    resultStr = config.get(sectionName,keyName)
    tmp='The old value is:'+resultStr
    #print tmp
    #更新指定section的option值
    config.set(sectionName,keyName,keyValue)
 
    #保存到配置文件
    config.write(open(ResultIniPath,'w'))

    #retCode=int(resultStr)
    #return retCode


if __name__=='__main__':

  try:
  
      test_case_type = sys.argv[1]
      test_case_platform = sys.argv[2]
      test_case = sys.argv[3]
      node_num = sys.argv[4]
      test_key = sys.argv[5]
      test_value = sys.argv[6]
      test_mode = sys.argv[7]
      
      #a = config.get(sectionName,valName)
      setPoint(test_case_type,test_case_platform,test_case,node_num,test_key,test_value,test_mode)
  
  except Exception as E:
      #print('str(Exception):', str(Exception))
      print('str(e):', str(E))
      #print('repr(e):', repr(E))
      #print('traceback.print_exc(): ', traceback.print_exc())

