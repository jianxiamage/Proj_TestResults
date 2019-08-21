#!/usr/bin python
#coding:utf-8
import sys
import os
reload(sys)
sys.setdefaultencoding('utf8')

import unittest
from HTMLTestRunner import HTMLTestRunner
import time

import unittest
from test_fk_math import TestFkMath
from test_hello import TestHello

test_cases = (TestHello, TestFkMath)
def whole_suite():
    # 创建测试加载器
    loader = unittest.TestLoader()
    # 创建测试包
    suite = unittest.TestSuite()
    # 遍历所有测试类
    for test_class in test_cases:
        # 从测试类中加载测试用例
        tests = loader.loadTestsFromTestCase(test_class)
        # 将测试用例添加到测试包中
        suite.addTests(tests)
    return suite   
# 用例路径
case_path = os.path.join(os.getcwd())

def all_case():
    discover = unittest.defaultTestLoader.discover(case_path, pattern="*.py",top_level_dir=None)
    print(discover)
    return discover


#if __name__ == '__main__':
#    with open('fk_test_report.txt', 'a') as f:
#        # 创建测试运行器（TestRunner），将测试报告输出到文件中
#        runner = unittest.TextTestRunner(verbosity=2, stream=f)
#        runner.run(whole_suite())


if __name__ == "__main__":
    #报告存放位置以及名称
    report_path = os.path.join(os.getcwd(),"report.html")
    fp=file(report_path,"w+")
    runner=HTMLTestRunner(stream=fp,title="hello",description="用例测试情况")
    runner.run(all_case())

