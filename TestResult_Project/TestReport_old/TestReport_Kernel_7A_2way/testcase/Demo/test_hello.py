#!/usr/bin/env python
#coding:utf-8

import unittest

from hello import *

class TestHello(unittest.TestCase):

    def setUp(self):
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...' 

   # 测试say_hello函数
    def test_say_hello(self):
        self.assertEqual(say_hello() , "Hello World.")
    # 测试add函数
    def test_add(self):
        self.assertEqual(add(3, 4) , 7)
