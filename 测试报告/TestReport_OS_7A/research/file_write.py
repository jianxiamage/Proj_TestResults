#!/usr/bin/env python
# -*- coding: utf-8 -*-

import commands
import sys
import os
import traceback

def write_file(input_str):
    retCode = 0
    txtFile="今天天气不错"
    name = "tmp_file.txt"
    f = open(name, "wb")
    f.write(txtFile)
    f.close()    
    return retCode


if __name__=='__main__':

  try:
  
      test_str = sys.argv[1]
      
      ret_code=write_file(test_str)
      print ret_code
  
  except Exception as E:
      #print('str(Exception):', str(Exception))
      print('str(e):', str(E))
      #print('repr(e):', repr(E))
      #print('traceback.print_exc(): ', traceback.print_exc())

