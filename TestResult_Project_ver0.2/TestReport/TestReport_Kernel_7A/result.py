##!/usr/bin/env python
# coding=utf-8

import commands
import sys
import traceback
import os

from get_TestInfo import *
from get_testcase import *
import re
import copy
import unittest

#from HTMLTestRunnerCN import HTMLTestRunner
#from HTMLTestRunner import HTMLTestRunner
from ExtentHTMLTestRunner import HTMLTestRunner
import time
from unittest import TestLoader

import webbrowser

#=============================================
report_file='report.html'
#=============================================
 
curDir=os.getcwd()
print('--------------------------') 
print curDir
print('--------------------------') 
#用例目录
case_dir = 'testcase'
test_suite_dir=curDir + '/' + case_dir
#报告目录
Report_dir= curDir

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
    print('Test Case count is:')    
    print(j)
    print('******************************************')    

    #for test_suite_new in package_tests_new:
    for test_case_new in test_suite_new:
            testunit.addTests(test_case_new)

    return testunit
 
alltestnames = creatsuite()
 
if __name__ == "__main__":

  try:

      TestType,TestPlat=getTestInfo()
      now = time.strftime("%Y-%m-%d %H_%M_%S")
      test_report = Report_dir
      filename = test_report + '/' + report_file
      print("******************************************")
      print("The test report file is:")
      print filename
      print("******************************************")
      fp = open(filename, 'wb')
      runner = HTMLTestRunner(
          stream=fp,
          title=u'Loongnix Automation Test',
          description=u'测试用例执行结果',
          test_type=TestType,
          test_plat=TestPlat,
      )
  
      runner.run(alltestnames)
      fp.close()
      #new_report = SendEmail.new_report(test_report)
      #SendEmail.send_file(new_report)  # 发送测试报告
  
  
      GEN_HTML = filename
      #运行完自动在网页中显示
      #webbrowser.open(GEN_HTML,new = 1)


  except Exception as E:
      #print('str(Exception):', str(Exception))
      print('str(e):', str(E))
      #print('repr(e):', repr(E))
      #print('traceback.print_exc(): ', traceback.print_exc())
