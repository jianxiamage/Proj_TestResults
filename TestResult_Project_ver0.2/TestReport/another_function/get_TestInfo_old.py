#!/usr/bin/env python
# -*- coding: utf-8 -*-

import commands
import sys  #引入模块
import os
import traceback

def getTestInfo():

    print("******************************************")
    curAbsPath = os.path.split(os.path.realpath(__file__))[0]
    #print(os.path.split(curAbsPath)[-1])
    curPath=os.path.basename(curAbsPath)  # 当前工作路径
    print('The current Path:')
    print(curPath)
    TestType=curPath.split('_')[1]
    TestPlat=curPath.split('_')[2]
    print(TestType)
    print(TestPlat)
    print("******************************************")

    return TestType,TestPlat


if __name__=='__main__':

  try:
  
      result_type,result_plat=getTestInfo()
      print(result_type)
      print(result_plat)
  
  except Exception as E:
      #print('str(Exception):', str(Exception))
      print('str(e):', str(E))
      #print('repr(e):', repr(E))
      #print('traceback.print_exc(): ', traceback.print_exc())
