#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys  #引入模块
import os
import traceback
import ConfigParser
import glob

import xlwt

#防止自动将ini文件中的键名转换成小写
class myconf(ConfigParser.ConfigParser):
    def __init__(self,defaults=None):
        ConfigParser.ConfigParser.__init__(self,defaults=None)
    def optionxform(self, optionstr):
        return optionstr


workbook = xlwt.Workbook(encoding='utf-8')
booksheet = workbook.add_sheet('UnixBench_8thread', cell_overwrite_ok=True)

ResultPath='/data/'
detailDir='Detail'
PointsPath='Points_Files'
curPointsPath='ini_Points'

def init_xls(iniFile,xlsFile,row_start,col_start,node_num):

    #-------------------------------------------------------------------------------
    #首先插入表头,包括每一行的测试字段以及三个测试节点

    booksheet.col(0).width = 9000


    alignment = xlwt.Alignment() # Create Alignment
    alignment.horz = xlwt.Alignment.HORZ_CENTER # May be: HORZ_GENERAL, HORZ_LEFT, HORZ_CENTER, HORZ_RIGHT, HORZ_FILLED, HORZ_JUSTIFIED, HORZ_CENTER_ACROSS_SEL, HORZ_DISTRIBUTED
    alignment.vert = xlwt.Alignment.VERT_CENTER # May be: VERT_TOP, VERT_CENTER, VERT_BOTTOM, VERT_JUSTIFIED, VERT_DISTRIBUTED
    style = xlwt.XFStyle() # Create Style
    style.alignment = alignment # Add Alignment to Style

    booksheet.write(0,0,'TestItem',style)

    #config = ConfigParser.ConfigParser()
    config = myconf()
    #print os.getcwd() #获取当前工作目录路径

    config.readfp(open(iniFile))

    sec_len = len(config.sections())
    print('---------------------------------')
    print sec_len
    print('---------------------------------')

    real_start_row = int(row_start) - 1
    node_tag = 'Node-' + str(node_num)

    i = 0
    j = 0

    curOpt_len = 0

    dictionary = {}
    for section in config.sections():
        dictionary[section] = {}
        print('---------------------------------')
        print section
        print('---------------------------------')
        xls_row = i + 2
        booksheet.write(xls_row,0,section)

        #每次循环新的section都要将列号恢复，因为如果不恢复列号，写入内容会向右偏移
        j = 0
        curOpt_len = 0
        for option in config.options(section):
            curOpt_len = len(config.options(section))
            dictionary[section][option] = config.get(section, option)
            #print dictionary[section][option]

            print 'option:%s,value:%s' %(option,dictionary[section][option])
            value = dictionary[section][option]
            value_float = float(value)
            row_num = real_start_row
            col_num = j + col_start
            merge_str = str(col_num)

            if i == 0:

               booksheet.write(real_start_row + 1,col_num,option,style)

            if i == (sec_len - 1):  #????
               booksheet.write_merge(real_start_row, real_start_row, col_num, col_num + curOpt_len + 1, merge_str) #col_num + curOpt_len + 1,加1的原因是需要排除当前列col_num
               booksheet.write(real_start_row,col_num,node_tag,style)

               #booksheet.write(row_num,col_num,value_float)
               #break

            j = j + 1

        i = i + 1

    workbook.save(xlsFile)


#以固定三个节点的方法初始化的方法，用于测试使用
def init_xls_static(iniFile,xlsFile):

    #-------------------------------------------------------------------------------
    #首先插入表头,包括每一行的测试字段以及三个测试节点

    booksheet.col(0).width = 9000

    alignment = xlwt.Alignment() # Create Alignment
    alignment.horz = xlwt.Alignment.HORZ_CENTER # May be: HORZ_GENERAL, HORZ_LEFT, HORZ_CENTER, HORZ_RIGHT, HORZ_FILLED, HORZ_JUSTIFIED, HORZ_CENTER_ACROSS_SEL, HORZ_DISTRIBUTED
    alignment.vert = xlwt.Alignment.VERT_CENTER # May be: VERT_TOP, VERT_CENTER, VERT_BOTTOM, VERT_JUSTIFIED, VERT_DISTRIBUTED
    style = xlwt.XFStyle() # Create Style
    style.alignment = alignment # Add Alignment to Style

    #初始化Excel表头
    booksheet.write(0,0,'TestItem')
    booksheet.write_merge(0, 0, 1, 3, 'Node-1')
    booksheet.write(0,1,'Node-1',style)
    booksheet.write_merge(0, 0, 4, 6, 'Node-2')
    booksheet.write(0,4,'Node-2',style)
    booksheet.write_merge(0, 0, 7, 9, 'Node-3')
    booksheet.write(0,7,'Node-3',style)

    #config = ConfigParser.ConfigParser()
    config = myconf()
    #print os.getcwd() #获取当前工作目录路径

    config.readfp(open(iniFile))
     
    sec_len = len(config.sections())
    print('---------------------------------')
    print sec_len
    print('---------------------------------')

    i = 0
    j = 0

    

    dictionary = {}
    for section in config.sections():
        dictionary[section] = {}
        print('---------------------------------')
        print section
        print('---------------------------------')
        xls_row = i + 2
        booksheet.write(xls_row,0,section)

        for option in config.options(section):
            dictionary[section][option] = config.get(section, option)
            #print dictionary[section][option]
            print 'option:%s,value:%s' %(option,dictionary[section][option])
            value = dictionary[section][option]
            #booksheet.write(j,0,option)
            if (i == 0):
              m = j + 1
              booksheet.write(1,m,option)
              booksheet.write(1,m + 3,option)
              booksheet.write(1,m + 6,option)

            j = j + 1
           
        i = i + 1

    workbook.save(xlsFile)

def end_xls(iniFile,xlsFile,row_start,col_start):

    #-------------------------------------------------------------------------------
    #首先插入表头,包括每一行的测试字段以及三个测试节点

    booksheet.col(0).width = 9000

    alignment = xlwt.Alignment() # Create Alignment
    alignment.horz = xlwt.Alignment.HORZ_CENTER # May be: HORZ_GENERAL, HORZ_LEFT, HORZ_CENTER, HORZ_RIGHT, HORZ_FILLED, HORZ_JUSTIFIED, HORZ_CENTER_ACROSS_SEL, HORZ_DISTRIBUTED
    alignment.vert = xlwt.Alignment.VERT_CENTER # May be: VERT_TOP, VERT_CENTER, VERT_BOTTOM, VERT_JUSTIFIED, VERT_DISTRIBUTED
    style = xlwt.XFStyle() # Create Style
    style.alignment = alignment # Add Alignment to Style

    #config = ConfigParser.ConfigParser()
    config = myconf()
    #print os.getcwd() #获取当前工作目录路径

    config.readfp(open(iniFile))

    sec_len = len(config.sections())
    print('---------------------------------')
    print sec_len
    print('---------------------------------')

    real_start_row = int(row_start) + sec_len - 1

    i = 0
    j = 0

    curOpt_len = 0

    dictionary = {}
    for section in config.sections():
        dictionary[section] = {}
        print('---------------------------------')
        print section
        print('---------------------------------')
        xls_row = i + 2
        #booksheet.write(xls_row,0,section)

        #每次循环新的section都要将列号恢复，因为如果不恢复列号，写入内容会向右偏移
        j = 0
        curOpt_len = 0
        for option in config.options(section):
            curOpt_len = len(config.options(section))
            dictionary[section][option] = config.get(section, option)
            #print dictionary[section][option]
            print 'option:%s,value:%s' %(option,dictionary[section][option])
            value = dictionary[section][option]
            value_float = float(value)
            row_num = real_start_row
            col_num = j + col_start
            merge_str = str(col_num)
            if i == (sec_len - 1):  #循环至最后一个section时，也就是最后一行测试结果时，需要将右侧的表格进行合并
               booksheet.write_merge(real_start_row, real_start_row, col_num, col_num + curOpt_len + 1, merge_str) #col_num + curOpt_len + 1,加1的原因是需要排除当前列col_num
               booksheet.write(real_start_row,col_num,value_float,style)
               #booksheet.write(row_num,col_num,value_float)
               #break

            j = j + 1

        i = i + 1

    workbook.save(xlsFile)

def write_xls(iniFile,xlsFile,row_start,col_start):

    alignment = xlwt.Alignment() # Create Alignment
    alignment.horz = xlwt.Alignment.HORZ_LEFT # May be: HORZ_GENERAL, HORZ_LEFT, HORZ_CENTER, HORZ_RIGHT, HORZ_FILLED, HORZ_JUSTIFIED, HORZ_CENTER_ACROSS_SEL, HORZ_DISTRIBUTED
    alignment.vert = xlwt.Alignment.VERT_CENTER # May be: VERT_TOP, VERT_CENTER, VERT_BOTTOM, VERT_JUSTIFIED, VERT_DISTRIBUTED
    style = xlwt.XFStyle() # Create Style
    style.alignment = alignment # Add Alignment to Style


    config = myconf()
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
        xls_row = i + 2
        #booksheet.write(xls_row,0,section)

        #每次循环新的section都要将列号恢复，因为如果不恢复列号，写入内容会向右偏移
        j = 0
        for option in config.options(section):
            dictionary[section][option] = config.get(section, option)
            #print dictionary[section][option]
            print 'option:%s,value:%s' %(option,dictionary[section][option])
            value = dictionary[section][option]
            value_float = float(value)
            row_num = i + row_start
            col_num = j + col_start
            booksheet.write(row_num,col_num,value_float,style)

            j = j + 1

        i = i + 1

    workbook.save(xlsFile)


def writeResult(TestType,Platform,TestCase,mode,count):

    print count
    IniPath = str(curPointsPath) + '/' + str(TestCase) + '_' + str(mode) + '.ini' 
    print('****************************************************')
    print IniPath
    print('****************************************************')
    ExcelPath = ResultPath + str(TestType) + '/' + str(Platform) + '/' + str(detailDir) + '/' + str(TestCase) + '/' + str(PointsPath) + '/' + str(TestCase) + '_' + str(mode) + '_' + str(Platform) + '_' + str(TestType)  + '.xls' 
    print IniPath
    print ExcelPath
    #init_xls_static(IniPath,ExcelPath)

    #这里直接调用init_xls_static，而不采用下面的循环赋值方式可以快速方便的完成excel初始化表头，
    #但本方法的局限性是只针对三个节点，不能扩展使用，下面的方法可以扩展到N个节点
    #但为方便测试使用，因此暂时保留本方法

    countNum = int(count) + 1
    for i in range(1,countNum):
       print '第%d个节点' %(i)
       ResultIniPath = str(ResultPath) + str(TestType) + '/' + str(Platform) + '/' + str(detailDir) + '/' + str(TestCase) + '/' + str(PointsPath) + '/' + str(TestCase) +  '_' + str(mode) + '_' + str(i) + '.ini'
       print ResultIniPath
       col_start_tag = 1 + (int(count))*(int(i)-1)
       print('****************************************************')
       print col_start_tag
       print('****************************************************')
       init_xls(ResultIniPath,ExcelPath,1,col_start_tag,i)

    countNum = int(count) + 1
    for i in range(1,countNum):
       print '第%d个节点' %(i)
       ResultIniPath = str(ResultPath) + str(TestType) + '/' + str(Platform) + '/' + str(detailDir) + '/' + str(TestCase) + '/' + str(PointsPath) + '/' + str(TestCase) +  '_' + str(mode) + '_' + str(i) + '.ini'
       print ResultIniPath
       col_start_tag = 1 + (int(count))*(int(i)-1)
       print('****************************************************')
       print col_start_tag
       print('****************************************************')
       write_xls(ResultIniPath,ExcelPath,2,col_start_tag)

    for i in range(1,countNum):
       print '第%d个节点' %(i)
       ResultIniPath = str(ResultPath) + str(TestType) + '/' + str(Platform) + '/' + str(detailDir) + '/' + str(TestCase) + '/' + str(PointsPath) + '/' + str(TestCase) +  '_' + str(mode) + '_' + str(i) + '.ini'
       print ResultIniPath
       col_start_tag = 1 + (int(count))*(int(i)-1)
       print('****************************************************')
       print col_start_tag
       print('****************************************************')
       end_xls(ResultIniPath,ExcelPath,2,col_start_tag)

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
