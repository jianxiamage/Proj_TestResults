#!/usr/bin/env python
#coding:utf-8

import unittest

from stressapp import *

class TestStressapp(unittest.TestCase):

    def setUp(self):
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...' 

    # 测试函数
    def test_Stressapp(self):
        self.assertEqual(getResult() , 0)
