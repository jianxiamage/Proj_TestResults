#!/usr/bin/env python
#coding:utf-8

import unittest

from get_test_result import *


class netperf_direct(unittest.TestCase):
    
    case_name='netperf_direct'

    def setUp(self):
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

    # 测试函数
    def test_Netperf_direct_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_Netperf_direct_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_Netperf_direct_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)

