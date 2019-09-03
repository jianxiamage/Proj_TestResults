#!/usr/bin/env python
# -*- coding: utf-8 -*-

import commands
import sys  #引入模块
import os
import traceback

def getTestInfo():

    print("******************************************")

    try:
        f_type = open('test_type.txt', 'r')
        TestType=f_type.readline().strip()
    finally:
        if f_type:
            f_type.close()

    try:
        f_plat = open('test_plat.txt', 'r')
        TestPlat=f_plat.readline().strip()
    finally:
        if f_plat:
            f_plat.close()

    #print(TestType)
    #print(TestPlat)

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
