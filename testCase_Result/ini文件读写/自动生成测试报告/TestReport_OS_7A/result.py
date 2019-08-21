#!/usr/bin/env python
#coding:utf-8
import sys
import os
reload(sys)
sys.setdefaultencoding('utf8')

import webbrowser

import unittest
#from HTMLTestRunner import HTMLTestRunner
from ExtentHTMLTestRunner import HTMLTestRunner
import time

#from testcase.test_hello import TestHello
from testcase.test_ping import ping
from testcase.test_wget import wget
from testcase.test_iozone import iozone
from testcase.test_disk_unzip_copy import disk_unzip_copy

from testcase.test_netperf_direct import netperf_direct
from testcase.test_scp_dir import scp_dir
from testcase.test_lmbench import lmbench
from testcase.test_stream import stream
from testcase.test_UnixBench import UnixBench
from testcase.test_stressapp import stressapp

from testcase.test_scp_2 import scp_2
from testcase.test_scp_1 import scp_1
from testcase.test_spec2000_1core import spec2000_1core
from testcase.test_spec2000_ncore import spec2000_ncore
from testcase.test_spec2006_1core import spec2006_1core
from testcase.test_spec2006_ncore import spec2006_ncore


from testcase.test_runltp import runltp
from testcase.test_scp_BigDir import scp_BigDir

from testcase.test_ltpstress import ltpstress

from testcase.test_IOstress import IOstress

from testcase.test_gcc import gcc
from testcase.test_glibc import glibc
from testcase.test_binutils import binutils
from testcase.test_openSSL import openSSL
from testcase.test_SpecJvm2008 import SpecJvm2008

#from testcase.test_stressapp import stressapp
#from testcase.test_ltpstress import ltpstress
#from testcase.test_spec2000_1core import spec2000_1core
#from testcase.test_spec2000_ncore import spec2000_ncore
#from testcase.test_spec2006_1core import spec2006_1core
#from testcase.test_spec2006_ncore import spec2006_ncore

#初始化操作:
cur_path = os.getcwd()
#print(cur_path)

#print('---------------------------------------------------------------------------------------------------')

#test_cases = (TestHello,TestStressapp)
# 用例路径
case_path = os.path.join(os.getcwd(),'testcase')
#print(case_path)

def all_case():
    discover = unittest.defaultTestLoader.discover(case_path, pattern="test*.py",top_level_dir=None)
    #print(discover)
    return discover


if __name__ == "__main__":
    #报告存放位置以及名称
    report_path = os.path.join(os.getcwd(),"report.html")
    fp=file(report_path,"w+")
    runner=HTMLTestRunner(stream=fp,title="Loongnix Automation Test",description="用例测试情况",verbosity=1)
    runner.run(all_case())


    GEN_HTML = report_path
    #运行完自动在网页中显示
    webbrowser.open(GEN_HTML,new = 1)

