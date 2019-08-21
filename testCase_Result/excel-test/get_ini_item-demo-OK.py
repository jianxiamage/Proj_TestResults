#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys  #引入模块
import os
import traceback
import ConfigParser
import glob

import xlwt

workbook = xlwt.Workbook(encoding='utf-8')
booksheet = workbook.add_sheet('Sheet 1', cell_overwrite_ok=True)

IPListIniFile='iozone_1.ini'


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
            booksheet.write(j,colNum,value)
            j = j + 1

        i = i + 1

    workbook.save(xlsFile)



def getResult():

    ip_list_path =  IPListIniFile
    config = ConfigParser.ConfigParser()
    #print os.getcwd() #获取当前工作目录路径

    config.readfp(open(ip_list_path))
#    sectionName = 'EXT3 File System'
#    keyName='ip_'+ str(NodeNum)
#    resultStr = config.get(sectionName,keyName)
#    retCode = resultStr
#    return retCode


#-------------------------------------------------------------------------------
#首先插入表头,包括每一行的测试字段以及三个测试节点
    listglob = []
    curDir = os.getcwd() #获取当前工作目录路径
    findFile = 'iozone*.ini'
    listglob = glob.glob(os.path.join(curDir,findFile))
    listglob.sort()
    #path = unicode(listglob[1],'utf-8')
    print listglob
    print('---------------------------------')

    #初始化Excel表头
    booksheet.write(0,0,'TestItem')
    booksheet.write(0,1,'Node-1')
    booksheet.write(0,2,'Node-2')
    booksheet.write(0,3,'Node-3')

    i = 0 #section
    j = 0 #key

    dictionary = {}
    for section in config.sections():
        dictionary[section] = {}
        print('---------------------------------')
        print section
        print('---------------------------------')

        for option in config.options(section):
            print('---------------------------------')
            print option
            print('---------------------------------')
            dictionary[section][option] = config.get(section, option)
            #print dictionary[section][option]
            print 'option:%s,value:%s' %(option,dictionary[section][option])
            j = j + 1
            booksheet.write(j,0,option)

        i = i + 1

    workbook.save('example.xls')

#-------------------------------------------------------------------------------

#    i = 0
#    j = 1
#
#    dictionary = {}
#    for section in config.sections():
#        dictionary[section] = {}
#        print('---------------------------------') 
#        print section
#        print('---------------------------------') 
#
#        for option in config.options(section):
#            dictionary[section][option] = config.get(section, option)
#            #print dictionary[section][option]
#            print 'option:%s,value:%s' %(option,dictionary[section][option])
#            value = dictionary[section][option]
#            booksheet.write(j,1,value)
#            j = j + 1
# 
#        i = i + 1
#
#    workbook.save('example.xls')

    write_xls('iozone_1.ini','example.xls',1)
    write_xls('iozone_2.ini','example.xls',2)
    write_xls('iozone_3.ini','example.xls',3)

    retCode = 0
    return retCode

if __name__=='__main__':

  try:
  
#      test_case_type = sys.argv[1]
#      test_case_platform = sys.argv[2]
#      test_case = sys.argv[3]
#      node_num = sys.argv[4]
      
      #result_code=getResult(test_case_type,test_case_platform,test_case,node_num)
      result_code=getResult()
      retCode=result_code
      print retCode
  
  except Exception as E:
      #print('str(Exception):', str(Exception))
      print('str(e):', str(E))
      #print('repr(e):', repr(E))
      #print('traceback.print_exc(): ', traceback.print_exc())
