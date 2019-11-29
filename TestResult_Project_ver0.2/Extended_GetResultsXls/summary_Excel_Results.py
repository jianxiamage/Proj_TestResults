#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys  #引入模块
import traceback
import ConfigParser

import xlwt
import xlrd
import os

ResultPath='/data/'
merge_path='merge_Excel'

resultXls_path = 'Results_Excel'

def checkNeedFile(inputFile):
    Files=os.listdir(inputFile)
    for i in range(len(Files)):
        # 提取文件夹内所有文件的后缀
        Files[i]=os.path.splitext(Files[i])[1]

    backName='.xls'
    if backName in Files:
        return True
    else:
        return False

def summaryExcel(TestType,TestPlat):

    Excel_File = ResultPath + str(TestType) +  '/' + TestPlat + '/' + resultXls_path + '/' + TestPlat + '_' + TestType + '.xls'
    print Excel_File

    Excel_Path = ResultPath + str(TestType) +  '/' + TestPlat + '/' + merge_path
    print Excel_Path

    if os.path.exists(Excel_Path):
        retFlag = checkNeedFile(Excel_Path)
        if retFlag == False:
          return 1
    else:
        print('The test file is not exists,Maybe it is running.')
        return 1

    work=xlwt.Workbook(Excel_File)                              #建立一个文件
    file_list=os.listdir(Excel_Path)
    for file in file_list:                                      #循环遍历列出所有文件名称
        file_name = os.path.join(Excel_Path,file)                     #路径+文件名
        if os.path.splitext(file)[1] == '.xls':
          workbook=xlrd.open_workbook(file_name)                #打开第一个文件
          sheet_name=workbook.sheet_names()                     #获取第一个文件的sheet名称
          for file_1 in sheet_name:                             #循环遍历每个sheet
            val=[]
            sheet=work.add_sheet(file_1,cell_overwrite_ok=True) #新建一个sheet
            table=workbook.sheet_by_name(file_1)                #以名字为索引
            rows=table.nrows                                    #获取sheet行数
            clos=table.ncols                                    #获取sheet列数目
            for i in range(rows):                               #循环遍历每一行
                val.append(table.row_values(i))                 #获取一行的值
                for x in range(len(val)):
                    for y in range(len(val[x])):
                        sheet.write(x,y,val[x][y])
    work.save(Excel_File)

    return 0 


if __name__=='__main__':

  try:
  
      test_type = sys.argv[1]
      test_plat = sys.argv[2]
      
      retCode = summaryExcel(test_type,test_plat)

      print retCode
  
  except Exception as E:
      #print('str(Exception):', str(Exception))
      print('str(e):', str(E))
      #print('repr(e):', repr(E))
      #print('traceback.print_exc(): ', traceback.print_exc())
