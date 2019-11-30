#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys  #引入模块
import os
import traceback
import ConfigParser

from get_GroupNum import *

ResultPath='/data/'
IPListIniFile='ip_list.ini'
IPListIniFileName='ip_list'

def get_IP(TestType,Platform,TestCase,NodeNum):

    #ip_list_path = ResultPath + str(TestType) + '/' + str(Platform) + '/' + IPListIniFileName + '_' + TestType + '_' + Platform + '.ini'
    ip_list_path = ResultPath + str(TestType) + '/' + str(Platform) + '/' + IPListIniFile
    config = ConfigParser.ConfigParser()
    #print os.getcwd() #获取当前工作目录路径

    config.readfp(open(ip_list_path))
    Group_num=getGroupNumByName(TestType,TestCase)
    tmp='获取的小组编号:' + Group_num
    #print tmp
    sectionName='Group'+ str(Group_num)
    keyName='ip_'+ str(NodeNum)
    resultStr=config.get(sectionName,keyName)
    retCode=resultStr
    return retCode


if __name__=='__main__':

  try:
  
      test_case_type = sys.argv[1]
      test_case_platform = sys.argv[2]
      test_case = sys.argv[3]
      node_num = sys.argv[4]
      
      #a = config.get(sectionName,valName)
      result_code=get_IP(test_case_type,test_case_platform,test_case,node_num)
      retCode=result_code
      print retCode
  
  except Exception as E:
      #print('str(Exception):', str(Exception))
      print('str(e):', str(E))
      #print('repr(e):', repr(E))
      #print('traceback.print_exc(): ', traceback.print_exc())
