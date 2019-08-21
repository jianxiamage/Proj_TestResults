#!/usr/bin/env python
#coding:utf-8

import unittest

from get_test_result import *


class binutils(unittest.TestCase):
    
    case_name='binutils'

    def setUp(self):
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

    # 测试函数
    def test_Binutils_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_Binutils_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_Binutils_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)

