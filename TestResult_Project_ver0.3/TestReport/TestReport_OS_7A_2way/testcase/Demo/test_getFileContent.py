#!/usr/bin/env python
#coding=utf-8

import subprocess
import commands

#retStr = subprocess.call("echo Hello World", shell=True)
#print(retStr)

retCode,output = commands.getstatusoutput('cat testResultIni_path.txt')
print  retCode
print  output
