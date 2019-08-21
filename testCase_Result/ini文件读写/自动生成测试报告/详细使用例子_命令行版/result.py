#!/usr/bin python
#coding:utf-8
import sys
reload(sys)
sys.setdefaultencoding('utf8')

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
if __name__ == '__main__':
    # 创建测试运行器（TestRunner）
    runner = unittest.TextTestRunner(verbosity=2)
    runner.run(whole_suite())
