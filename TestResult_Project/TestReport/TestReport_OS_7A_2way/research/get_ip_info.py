#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys  #引入模块
import os
import traceback
import ConfigParser

from get_node_ip import *


def getIP(TestType,Platform,TestCase,NodeNum):

    #print os.getcwd() #获取当前工作目录路径

    ip_info = get_IP(TestType,Platform,TestCase,NodeNum)
    retStr = ip_info
    return retStr


if __name__=='__main__':

  try:
  
      test_case_type = sys.argv[1]
      test_case_platform = sys.argv[2]
      test_case = sys.argv[3]
      node_num = sys.argv[4]
      
      result_code=getIP(test_case_type,test_case_platform,test_case,node_num)
      retCode=result_code
      print retCode
  
  except Exception as E:
      #print('str(Exception):', str(Exception))
      print('str(e):', str(E))
      #print('repr(e):', repr(E))
      #print('traceback.print_exc(): ', traceback.print_exc())
