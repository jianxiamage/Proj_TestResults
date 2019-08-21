#!/usr/bin/env python
#coding=utf-8

import os
import sys


#初始化操作:
cur_path = os.getcwd()
print(cur_path)

print('-----------------------------------------------------')

filename = os.path.split(cur_path)[1]
print(filename)

destDir=filename.split('_')

print(destDir)

test_type = destDir[1]
test_plat = destDir[2]

print(test_type)
print(test_plat)
