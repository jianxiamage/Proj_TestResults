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

def getSectionCount(TestType,Platform,TestCase):

    #ip_list_path = ResultPath + str(TestType) + '/' + str(Platform) + '/' + IPListIniFileName + '_' + TestType + '_' + Platform + '.ini'
    ip_list_path = ResultPath + str(TestType) + '/' + str(Platform) + '/' + IPListIniFile
    config = ConfigParser.ConfigParser()
    #print os.getcwd() #获取当前工作目录路径

    #config.sections()

    config.readfp(open(ip_list_path))
    Group_num=getGroupNumByName(TestType,TestCase)
    tmp='获取的小组编号:' + Group_num
    #print tmp
    sectionName='Group'+ str(Group_num)
    option_list=config.options(sectionName)
    option_count=len(option_list)
    return option_count


if __name__=='__main__':

  try:
  
      test_case_type = sys.argv[1]
      test_case_platform = sys.argv[2]
      test_case = sys.argv[3]
      
      #a = config.get(sectionName,valName)
      count_nodes=getSectionCount(test_case_type,test_case_platform,test_case)
      retCode=count_nodes
      print retCode
  
  except Exception as E:
      #print('str(Exception):', str(Exception))
      print('str(e):', str(E))
      #print('repr(e):', repr(E))
      #print('traceback.print_exc(): ', traceback.print_exc())
