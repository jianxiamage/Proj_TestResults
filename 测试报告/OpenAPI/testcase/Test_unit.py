#!/usr/bin/env python
#encoding=utf-8

import os
import sys 
import traceback
import unittest
from HTMLTestRunner import HTMLTestRunner

import webbrowser


class test_raise(unittest.TestCase):
    def setUp(self):
        pass

    def test01(self):
        try:
            print 2/0
        except Exception,e:
            #这里用的是：print e.message，观察test01的测试报告
            print e.message
        else:
            print 'test01-else'
        finally:
            print 'test01-finally'

    def test02(self):
        try:
            print 2/0
        except Exception,e:
            #这里用的是 ：raise e，观察test02的测试报告
            raise e
        else:
            print 'test02-else'
        finally:
            print 'test02-finally'

    def tearDown(self):
        pass


class test_hello(unittest.TestCase):
    def setUp(self):
        pass

    def test01(self):
        try:
            print 2/0
        except Exception,e:
            #这里用的是：print e.message，观察test01的测试报告
            print e.message
        else:
            print 'test01-else'
        finally:
            print 'test01-finally'

    def test02(self):
        try:
            print 2/0
        except Exception,e:
            #这里用的是 ：raise e，观察test02的测试报告
            raise e
        else:
            print 'test02-else'
        finally:
            print 'test02-finally'

    def tearDown(self):
        pass

