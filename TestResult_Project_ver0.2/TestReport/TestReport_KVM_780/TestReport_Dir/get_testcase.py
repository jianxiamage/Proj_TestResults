#!/usr/bin/env python
# -*- coding: utf-8 -*-

import commands
import sys
import os
import traceback

import re

def get_str(input_str):

    '''
    #获取测试返回的列表信息,截取其中的测试用例名称
    #便于之后将其重新排序(默认是ASCII排序)
    #设定排序文件:Std_CaseList.txt
    #示例:

    a = ('<unittest.suite.TestSuite tests=[<Test_Results.wget testMethod=test_Wget_Node1>,'
         ' <Test_Results.wget testMethod=test_Wget_Node2>,'
         ' <Test_Results.wget testMethod=test_Wget_Node3>]>')

    '''

    find_str = re.findall(r'(\[.*?\])', str(input_str)) #取出中括号部分内容
    #print(find_str)
    first_str = ''.join(find_str)
    sec_list = re.split('[ ]',first_str)
    #print(sec_list[0])
    third_list = re.split('[.]',sec_list[0])
    #print(third_list[1])
    return third_list[1]


if __name__=='__main__':

  try:
  
      test_str = sys.argv[1]
  
      get_str(test_str)
#      ret_code=exec_cmd(test_str)
#      print ret_code[0]

  except Exception as E:
      #print('str(Exception):', str(Exception))
      print('str(e):', str(E))
      #print('repr(e):', repr(E))
      #print('traceback.print_exc(): ', traceback.print_exc())

