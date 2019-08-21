#!/usr/bin/env python
#coding:utf-8
import sys
import os
reload(sys)
sys.setdefaultencoding('utf8')

import webbrowser

import unittest
#from HTMLTestRunner import HTMLTestRunner
from ExtentHTMLTestRunner import HTMLTestRunner
import time

from testcase.test_hello import TestHello
from testcase.test_stressapp import TestStressapp

test_cases = (TestHello,TestStressapp)
# 用例路径
case_path = os.path.join(os.getcwd(),'testcase')
print(case_path)

def all_case():
    discover = unittest.defaultTestLoader.discover(case_path, pattern="test*.py",top_level_dir=None)
    #print(discover)
    return discover


if __name__ == "__main__":
    #报告存放位置以及名称
    report_path = os.path.join(os.getcwd(),"report.html")
    fp=file(report_path,"w+")
    runner=HTMLTestRunner(stream=fp,title="Loongnix Automation Test",description="用例测试情况",verbosity=1)
    runner.run(all_case())


    GEN_HTML = report_path
    #运行完自动在网页中显示
    webbrowser.open(GEN_HTML,new = 1)

