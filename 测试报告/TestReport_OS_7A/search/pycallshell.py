#!/usr/bin/env python
# -*- coding: utf-8 -*-

import commands
import sys
import os
import traceback

def exec_cmd(input_str):

    cmd_str = 'get_case_name.sh'
    cmdInput = 'sh ' + str(cmd_str) + ' ' + str(input_str)
    retCode,output = commands.getstatusoutput(cmdInput)
    
    return retCode,output


if __name__=='__main__':

  try:
  
      test_str = sys.argv[1]
      
      ret_code=exec_cmd(test_str)
      print('xxxxxxxxxxxxxxxxxxxxxxxxx')
      print ret_code[0]
      print('xxxxxxxxxxxxxxxxxxxxxxxxx')
      print ret_code[1]
      print('xxxxxxxxxxxxxxxxxxxxxxxxx')
  
  except Exception as E:
      #print('str(Exception):', str(Exception))
      print('str(e):', str(E))
      #print('repr(e):', repr(E))
      #print('traceback.print_exc(): ', traceback.print_exc())

