#!/usr/bin/env python
#coding:utf-8

import os

# 该方法简单地返回结果返回值
def getResult(TestCase,NodeNum):
    TestCase='stressapp'
    cmd='python get_test_result '+ TestCase + ' ' + NodeNum
    test_retCode=os.system(cmd)
    ret=test_retcode
    return ret
