##!/usr/bin/env python
# coding=utf-8

import commands
import sys
import traceback
import os

from get_testcase import *
import re
import copy
import unittest
#from HTMLTestRunner import HTMLTestRunner
from ExtentHTMLTestRunner import HTMLTestRunner
import time
from unittest import TestLoader

import webbrowser
 
curDir=os.getcwd()
print('--------------------------') 
print curDir
print('--------------------------') 
#用例目录
case_dir = 'testcase'
test_suite_dir=curDir + '/' + case_dir
#报告目录
Report_dir= curDir

def write_file(input_str):
    retCode = 0
    txtFile=str(input_str)
    name = "tmp_file.txt"
    f = open(name, "wb")
    f.write(txtFile)
    f.close()
    return retCode


#---------------------------------------------------------------------------
def exec_cmd():

    cmd_str = 'get_case_name.sh'
    #cmdInput = 'sh ' + str(cmd_str) + ' ' + str(input_str)
    cmdInput = 'sh ' + str(cmd_str)
    retCode,output = commands.getstatusoutput(cmdInput)
    #print  retCode
    #print  output

    return retCode,output
#---------------------------------------------------------------------------
def creatsuite():

    package_tests_new = []
    test_suite_new = [] 
   
    testunit = unittest.TestSuite()
    # 定义测试文件查找的目录
    test_dir =test_suite_dir
    # 定义 discover 方法的参数
    package_tests = unittest.defaultTestLoader.discover(test_dir,
                                                   pattern='Test*.py',
                                                   top_level_dir=None)
    # package_tests=TestLoader.discover(start_dir=test_dir, pattern='Test*.py')
    # discover 方法筛选出来的用例，循环添加到测试套件中


    #----------------------------------------------------------------------------
    for test_suite in package_tests:
      for test_case in test_suite:
         pass
    new_test_suite = copy.deepcopy(test_suite)

    result=[]
    with open('Std_CaseList.txt','r') as f:
        for line in f:
            result.append(list(line.strip('\n').split(',')))
    #print(result)
    
    for i in xrange(len(result)):
        print i + 1, result[i]
        str_case = ''.join(result[i])
    
        #for test_suite in package_tests:
        for test_case in new_test_suite:
                #testunit.addTests(test_case)
                test_str=str(test_case)
                #write_file(test_str)
                #ret_code,ret_str = exec_cmd()
                ret_str = get_str(test_str)
                if ret_str == str_case:
                   test_suite_new.append(test_case)         
    j = 0
    for j in xrange(len(test_suite_new)):
    #for test_case in test_suite_new:
        j = j + 1

    print('******************************************')    
    print('test case count is:')    
    print(j)
    print('******************************************')    

    #----------------------------------------------------------------------------
#    i = 0
#    for test_suite in package_tests:
#        for test_case in test_suite:
#            testunit.addTests(test_case)
#            #print(testunit)
#            if i == 0:
#              print('==========================')
#              print(test_case)
#              print('==========================')
#              test_str=str(test_case)
#              write_file(test_str)
#              ret_code,ret_str = exec_cmd()
#              print('ret_code:--------')
#              print ret_code
#              print('ret_str:--------')
#              print ret_str
#              print('==========================')
#            i = i + 1

    #----------------------------------------------------------------------------

    #for test_suite_new in package_tests_new:
    for test_case_new in test_suite_new:
            testunit.addTests(test_case_new)

    return testunit
 
alltestnames = creatsuite()
 
if __name__ == "__main__":

  try:

      now = time.strftime("%Y-%m-%d %H_%M_%S")
      test_report = Report_dir
      #filename = test_report + now + 'result.html'
      filename = test_report + '/' + 'report.html'
      print("***********************************")
      print("The test report file is:")
      print filename
      print("***********************************")
      fp = open(filename, 'wb')
      runner = HTMLTestRunner(
          stream=fp,
          title=u'Loongnix Automation Test',
          description=u'测试用例执行结果'
      )
  
      runner.run(alltestnames)
      fp.close()
      #new_report = SendEmail.new_report(test_report)
      #SendEmail.send_file(new_report)  # 发送测试报告
  
  
      GEN_HTML = filename
      #运行完自动在网页中显示
      webbrowser.open(GEN_HTML,new = 1)


  except Exception as E:
      #print('str(Exception):', str(Exception))
      print('str(e):', str(E))
      #print('repr(e):', repr(E))
      #print('traceback.print_exc(): ', traceback.print_exc())
