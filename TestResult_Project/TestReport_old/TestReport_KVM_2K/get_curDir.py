#!/usr/bin/env python
#coding=utf-8

import os
import sys


#初始化操作:
cur_path = os.getcwd()
print(cur_path)

print('-----------------------------------------------------')

local_filename = "/root/path/treee"
filename = os.path.split(local_filename)[1]
print(filename)


filename = os.path.split(cur_path)[1]
print(filename)

destDir=filename.split('_')

print(destDir)
