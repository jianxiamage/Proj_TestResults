#!/usr/bin python
#coding:utf-8
import sys
reload(sys)
sys.setdefaultencoding('utf8')

import unittest
from HTMLTestRunner import HTMLTestRunner
import time

import webbrowser
#命名生成的html

class Test(unittest.TestCase):
    #用于测试用例执行前的初始化工作
    def setUp(self):
        print("test start")
 
    def test_bbb(self):
        print("test bbb")
 
    def test_aaa(self):
        print("test aaa")       
    #用于测试用例执行之后的善后工作
    def tearDown(self):
        print("test end")

if __name__ == '__main__':
 
    suite=unittest.TestSuite()
    suite.addTest(Test("test_bbb"))
    suite.addTest(Test("test_aaa"))
    now=time.strftime("%Y-%m-%d %H_%M_%S")
    #定义报告存放路径
    filename = now +'result.html'
    fp=open(filename,'wb')
    #定义测试报告
    runner= HTMLTestRunner(stream=fp,title='测试报告',description='用例执行情况：')
    runner.run(suite)
    fp.close()#关闭报告文件


    GEN_HTML = filename
    #运行完自动在网页中显示
    webbrowser.open(GEN_HTML,new = 1) 
