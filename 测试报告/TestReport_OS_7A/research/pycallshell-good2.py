#!/usr/bin/env python
# -*- coding: utf-8 -*-

import commands
import sys
import os
import traceback

import re

def exec_cmd(input_str):

    cmd_str = 'get_case_name.sh'
    cmdInput = 'sh ' + str(cmd_str) + ' ' + str(input_str)
    retCode,output = commands.getstatusoutput(cmdInput)
    
    return retCode,output

def get_str():
    #a = "as,fsf[safds,sf]abc"
    a = "<unittest.suite.TestSuite tests=[<Test_Results.wget testMethod=test_Wget_Node1>, <Test_Results.wget testMethod=test_Wget_Node2>, <Test_Results.wget testMethod=test_Wget_Node3>]>"
    input_str=a
    b = re.findall(r'(\[.*?\])', str(input_str))
    print(b) 
    first_str = ''.join(b)
    sec_list = re.split('[ ]',first_str) 
    print(sec_list[0]) 
    third_list = re.split('[.]',sec_list[0]) 
    print(third_list[1]) 


if __name__=='__main__':

  try:
  
      #test_str = sys.argv[1]
#      
#      ret_code=exec_cmd(test_str)
#      print('xxxxxxxxxxxxxxxxxxxxxxxxx')
#      print ret_code[0]
#      print('xxxxxxxxxxxxxxxxxxxxxxxxx')
#      print ret_code[1]
#      print('xxxxxxxxxxxxxxxxxxxxxxxxx')
  
      #get_str(test_str)
      get_str()

  except Exception as E:
      #print('str(Exception):', str(Exception))
      print('str(e):', str(E))
      #print('repr(e):', repr(E))
      #print('traceback.print_exc(): ', traceback.print_exc())

