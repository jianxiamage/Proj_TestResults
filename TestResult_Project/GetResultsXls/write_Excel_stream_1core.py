#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys  #引入模块
import os
import traceback
import ConfigParser
import glob

import xlwt

workbook = xlwt.Workbook(encoding='utf-8')
booksheet = workbook.add_sheet('stream_1core', cell_overwrite_ok=True)

ResultPath='/data/'
detailDir='Detail'
PointsPath='Points_Files'
curPointsPath='ini_Points'


def write_xls(iniFile,xlsFile,colNum):

    alignment = xlwt.Alignment() # Create Alignment
    alignment.horz = xlwt.Alignment.HORZ_LEFT   # May be: HORZ_GENERAL, HORZ_LEFT, HORZ_CENTER, HORZ_RIGHT, HORZ_FILLED, HORZ_JUSTIFIED, HORZ_CENTER_ACROSS_SEL, HORZ_DISTRIBUTED
    alignment.vert = xlwt.Alignment.VERT_CENTER # May be: VERT_TOP, VERT_CENTER, VERT_BOTTOM, VERT_JUSTIFIED, VERT_DISTRIBUTED
    style = xlwt.XFStyle() # Create Style
    style.alignment = alignment # Add Alignment to Style

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
            value_float = float(value)
            booksheet.write(j,colNum,value_float,style)
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


def writeResult(TestType,Platform,TestCase,mode,count):

    print count
    IniPath = str(curPointsPath) + '/' + str(TestCase) + '_' + str(mode) + '.ini' 
    ExcelPath = ResultPath + str(TestType) + '/' + str(Platform) + '/' + str(detailDir) + '/' + str(TestCase) + '/' + str(PointsPath) + '/' + str(TestCase) + '_' + str(mode) + '_' + str(Platform) + '_' + str(TestType)  + '.xls' 
    print IniPath
    print ExcelPath
    init_xls(IniPath,ExcelPath)

    #ResultIniPath = ResultPath + str(TestType) + '/' + str(Platform) + '/' + str(TestCase) + '/' + str(PointsPath) + '/' + str(TestCase) + '_' +  str(1) + '.ini' 
    #write_xls(ResultIniPath,ExcelPath,2)
    countNum = int(count) + 1
    for i in range(1,countNum):
       print '第%d个节点' %(i)
       ResultIniPath = str(ResultPath) + str(TestType) + '/' + str(Platform) + '/' + str(detailDir) + '/' + str(TestCase) + '/' + str(PointsPath) + '/' + str(TestCase) +  '_' + str(mode) + '_' + str(i) + '.ini' 
       print ResultIniPath
       write_xls(ResultIniPath,ExcelPath,i)

       #write_xls(ResultIniPath,xlsFile,1)
       #write_xls('iozone_2.ini',xlsFile,2)
       #write_xls('iozone_3.ini',xlsFile,3)
    print('---------------------------------------------------')
    print('Please check by the Excel file:')
    print ExcelPath
    print('---------------------------------------------------')
    retCode = 0
    return retCode

if __name__=='__main__':

  try:
  
      test_case_type = sys.argv[1]
      test_case_platform = sys.argv[2]
      test_case = sys.argv[3]
      test_mode = sys.argv[4]
      node_count = sys.argv[5]
      
      result_code = writeResult(test_case_type,test_case_platform,test_case,test_mode,node_count)
      retCode = result_code
      print retCode
  
  except Exception as E:
      #print('str(Exception):', str(Exception))
      print('str(e):', str(E))
      #print('repr(e):', repr(E))
      #print('traceback.print_exc(): ', traceback.print_exc())
