#!/usr/bin/env python
# -*- coding: utf-8 -*-

from get_TestResultFilePath import *
import sys 
import os
import traceback
import ConfigParser

IniPath='/data/TestResultFilePath.ini'
def setIniPath(input_file,input_content):

    with open(input_file,'w') as file_object:
       file_object.write(input_content)
    return 0


if __name__=='__main__':

  try:
  
    #初始化操作:
    cur_path = os.getcwd()
    print(cur_path)
    
    print('-----------------------------------------------------')
    
    filename = os.path.split(cur_path)[1]
    print(filename)
    
    destDir=filename.split('_')
    
    print(destDir)
    
    test_type = destDir[1]
    test_plat = destDir[2]
    
    print(test_type)
    print(test_plat) 

    #base_dir = os.path.dirname(__file__)
    # 获取当前文件目录
    #path = os.path.join(base_dir,'123.txt')

    testcase_dir = 'testcase'
    case_path = os.path.join(os.getcwd() , testcase_dir)
    iniFile = 'testResultIni_path.txt'
    iniFileAbsPath = os.path.join(case_path , iniFile)
    print(iniFileAbsPath)
    iniFilePath = getIniPath(test_type , test_plat)
    iniResultsFile = str(iniFilePath) + '/' + 'TestResults.ini'
    print(iniResultsFile)
    setIniPath(iniFileAbsPath , iniResultsFile)
 
  except Exception as E:
      #print('str(Exception):', str(Exception))
      print('str(e):', str(E))
      #print('repr(e):', repr(E))
      #print('traceback.print_exc(): ', traceback.print_exc())
