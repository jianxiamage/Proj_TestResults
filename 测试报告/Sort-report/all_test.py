##!/usr/bin/env python
# coding=utf-8

import os
import unittest
from HTMLTestRunner import HTMLTestRunner
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

def creatsuite():
    testunit = unittest.TestSuite()
    # 定义测试文件查找的目录
    test_dir =test_suite_dir
    # 定义 discover 方法的参数
    package_tests = unittest.defaultTestLoader.discover(test_dir,
                                                   pattern='Test*.py',
                                                   top_level_dir=None)
    # package_tests=TestLoader.discover(start_dir=test_dir, pattern='Test*.py')
    # discover 方法筛选出来的用例，循环添加到测试套件中
    for test_suite in package_tests:
        for test_case in test_suite:
            testunit.addTests(test_case)
            print(testunit)
    return testunit
 
alltestnames = creatsuite()
 
if __name__ == "__main__":
    now = time.strftime("%Y-%m-%d %H_%M_%S")
    test_report =Report_dir
    #filename = test_report + now + 'result.html'
    filename = test_report + '/' + 'result.html'
    print filename
    fp = open(filename, 'wb')
    runner = HTMLTestRunner(
        stream=fp,
        title=u'OpenAPI测试报告',
        description=u'测试用例执行结果'
    )
 
    runner.run(alltestnames)
    fp.close()
    #new_report = SendEmail.new_report(test_report)
    #SendEmail.send_file(new_report)  # 发送测试报告


    GEN_HTML = filename
    #运行完自动在网页中显示
    webbrowser.open(GEN_HTML,new = 1)

