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
    def test_Stressapp_Node1(self):
        self.assertEqual(getResult() , 0)


    def test_Stressapp_Node2(self):
        self.assertEqual(getResult() , 0)


    def test_Stressapp_Node3(self):
        self.assertEqual(getResult() , 0)

