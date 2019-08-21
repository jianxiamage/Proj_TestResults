#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys  #引入模块
import os
import traceback
import ConfigParser
import glob

import xlwt

workbook = xlwt.Workbook(encoding='utf-8')
booksheet = workbook.add_sheet('iozone', cell_overwrite_ok=True)

def write_xls(iniFile,xlsFile,colNum):

    config = ConfigParser.ConfigParser()
    #print os.getcwd() #获取当前工作目录路径

    config.readfp(open(iniFile))

    i = 0
    j = 1

    dictionary = {}
    for section in config.sections():
        dictionary[section] = {}
        print('---------------------------------')
        print section
        print('---------------------------------')

        for option in config.options(section):
            dictionary[section][option] = config.get(section, option)
            #print dictionary[section][option]
            print 'option:%s,value:%s' %(option,dictionary[section][option])
            value = dictionary[section][option]
            value_int = int(value)
            booksheet.write(j,colNum,value_int)
            j = j + 1

        i = i + 1

    workbook.save(xlsFile)

def init_xls(iniFile,xlsFile):

    #-------------------------------------------------------------------------------
    #首先插入表头,包括每一行的测试字段以及三个测试节点

    #初始化Excel表头
    booksheet.write(0,0,'TestItem')
    booksheet.write(0,1,'Node-1')
    booksheet.write(0,2,'Node-2')
    booksheet.write(0,3,'Node-3')

    config = ConfigParser.ConfigParser()
    #print os.getcwd() #获取当前工作目录路径

    config.readfp(open(iniFile))

    i = 0
    j = 0

    dictionary = {}
    for section in config.sections():
        dictionary[section] = {}
        print('---------------------------------')
        print section
        print('---------------------------------')

        for option in config.options(section):
            dictionary[section][option] = config.get(section, option)
            #print dictionary[section][option]
            print 'option:%s,value:%s' %(option,dictionary[section][option])
            value = dictionary[section][option]
            j = j + 1
            booksheet.write(j,0,option)

        i = i + 1

    workbook.save(xlsFile)


def writeResult(iniFile,xlsFile):

    init_xls('iozone_1.ini',xlsFile)

    write_xls('iozone_1.ini',xlsFile,1)
    write_xls('iozone_2.ini',xlsFile,2)
    write_xls('iozone_3.ini',xlsFile,3)

    retCode = 0
    return retCode

if __name__=='__main__':

  try:
  
      test_inifile = sys.argv[1]
      test_xlsfile = sys.argv[2]
      
      #result_code=getResult(test_case_type,test_case_platform,test_case,node_num)
      result_code = writeResult('iozone_1.ini','iozone.xls')
      retCode = result_code
      print retCode
  
  except Exception as E:
      #print('str(Exception):', str(Exception))
      print('str(e):', str(E))
      #print('repr(e):', repr(E))
      #print('traceback.print_exc(): ', traceback.print_exc())
