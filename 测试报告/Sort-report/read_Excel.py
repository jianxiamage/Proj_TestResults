#!/usr/bin/env python
#coding=utf-8

import sys  #引入模块
import os
import traceback

import xlrd

TEST_DATA_EXCEL_FILE = 'std.xls'

def get_xls_case_by_index(sheet_name):

    xls_path = TEST_DATA_EXCEL_FILE 
    
    file = xlrd.open_workbook(xls_path) 
    
    sheet = file.sheet_by_name(sheet_name) 
    
    ncols = sheet.ncols 
    
    for j in range(ncols):
    
        cell_value = sheet.cell_value(0, j) 
    
        if cell_value == "fileName": 
    
           coll = j
    
        elif cell_value == "ClassName": 
    
           col2 = j
    
        elif cell_value == "caseName": 
    
           col3 = j
    
    nrows = sheet.nrows
    
    caseList =[]
    
    for i in range(1, nrows):
    
        if sheet.row_values(i)[0].lower().strip() == 'ready': 
    
            fileName = sheet.cell_value(i, coll) 
    
            ClassName = sheet.cell_value(i, col2) 
    
            caseName = sheet.cell_value(i, col3)
    
            case = '%s.%s("%s")'  % (fileName.strip(), ClassName.strip(), caseName.strip()) 
    
            caseList.append(case)

    return caseList



if __name__=='__main__':

  try:

      testCaseList = get_xls_case_by_index('case')
      #for i in range(len(retList)):
      #   print ("num：%s  val：%s" % (i + 1, retList[i]))
      #print(retList)
      for test_case in testCaseList:
          print('---------------')
          print(test_case)
          print('---------------')

  except Exception as E:
      #print('str(Exception):', str(Exception))
      print('str(e):', str(E))
      #print('repr(e):', repr(E))
      #print('traceback.print_exc(): ', traceback.print_exc())

