#!/usr/bin/env python
#coding:utf-8

import unittest

from get_test_result import *

#==============================================================
#TestCase: ping

class ping(unittest.TestCase):
    
    case_name='ping'

    def setUp(self):
        pass

    def tearDown(self):
        pass

    # 测试函数
    def test_ping_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_ping_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_ping_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)


#==============================================================
#TestCase: wget
class wget(unittest.TestCase):

    case_name='wget'

    def setUp(self):
        pass

    def tearDown(self):
        pass

    # 测试函数
    def test_wget_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_wget_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_wget_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)


#==============================================================
#TestCase: iozone

class iozone(unittest.TestCase):

    case_name='iozone'

    def setUp(self):
        pass

    def tearDown(self):
        pass

    # 测试函数
    def test_iozone_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_iozone_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_iozone_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)


#==============================================================
#TestCase: disk_unzip_copy
class disk_unzip_copy(unittest.TestCase):

    case_name='disk_unzip_copy'

    def setUp(self):
        pass

    def tearDown(self):
        pass

    # 测试函数
    def test_disk_unzip_copy_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_disk_unzip_copy_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_disk_unzip_copy_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)


#==============================================================
#TestCase: netperf
class netperf(unittest.TestCase):

    case_name='netperf'

    def setUp(self):
        pass

    def tearDown(self):
        pass

    # 测试函数
    def test_netperf_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_netperf_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_netperf_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)


#==============================================================
#TestCase: BasicSystemInfo
class BasicSystemInfo(unittest.TestCase):

    case_name='BasicSystemInfo'

    def setUp(self):
        pass

    def tearDown(self):
        pass

    # 测试函数
    def test_BasicSystemInfo_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_BasicSystemInfo_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_BasicSystemInfo_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)


#==============================================================
#TestCase: netperf_direct
class netperf_direct(unittest.TestCase):

    case_name='netperf-direct'

    def setUp(self):
        pass

    def tearDown(self):
        pass

    # 测试函数
    def test_netperf_direct_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_netperf_direct_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_netperf_direct_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)

#==============================================================
#TestCase: scp_dir
class scp_dir(unittest.TestCase):

    case_name='scp-dir'

    def setUp(self):
        pass

    def tearDown(self):
        pass

    # 测试函数
    def test_scp_dir_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_scp_dir_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_scp_dir_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)

#==============================================================
#TestCase: lmbench
class lmbench(unittest.TestCase):

    case_name='lmbench'

    def setUp(self):
        pass

    def tearDown(self):
        pass

    # 测试函数
    def test_lmbench_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_lmbench_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_lmbench_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)


#==============================================================
#TestCase: stream
class stream(unittest.TestCase):

    case_name='stream'

    def setUp(self):
        pass

    def tearDown(self):
        pass

    # 测试函数
    def test_stream_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_stream_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_stream_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)


#==============================================================
#TestCase: UnixBench
class UnixBench(unittest.TestCase):

    case_name='UnixBench'

    def setUp(self):
        pass

    def tearDown(self):
        pass

    # 测试函数
    def test_UnixBench_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_UnixBench_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_UnixBench_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)



#==============================================================
#TestCase: stressapp
class stressapp(unittest.TestCase):

    case_name='stressapp'

    def setUp(self):
        pass

    def tearDown(self):
        pass

    # 测试函数
    def test_stressapp_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_stressapp_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_stressapp_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)


#==============================================================
#TestCase: scp-2
class scp_2(unittest.TestCase):

    case_name='scp-2'

    def setUp(self):
        pass

    def tearDown(self):
        pass

    # 测试函数
    def test_scp_2_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_scp_2_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_scp_2_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)


#==============================================================
#TestCase: scp-1
class scp_1(unittest.TestCase):

    case_name='scp-1'

    def setUp(self):
        pass

    def tearDown(self):
        pass

    # 测试函数
    def test_scp_1_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_scp_1_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_scp_1_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)


#==============================================================
#TestCase: spec2000_1core
class spec2000_1core(unittest.TestCase):

    case_name='spec2000-1core'

    def setUp(self):
        pass

    def tearDown(self):
        pass

    # 测试函数
    def test_spec2000_1core_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_spec2000_1core_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_spec2000_1core_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)


#==============================================================
#TestCase: spec2000_ncore
class spec2000_ncore(unittest.TestCase):

    case_name='spec2000-ncore'

    def setUp(self):
        pass

    def tearDown(self):
        pass

    # 测试函数
    def test_spec2000_ncore_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_spec2000_ncore_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_spec2000_ncore_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)


#==============================================================
#TestCase: spec2006_1core 
class spec2006_1core(unittest.TestCase):

    case_name='spec2006-1core'

    def setUp(self):
        pass

    def tearDown(self):
        pass

    # 测试函数
    def test_spec2006_1core_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_spec2006_1core_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_spec2006_1core_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)


#==============================================================
#TestCase: spec2006_ncore 
class spec2006_ncore(unittest.TestCase):

    case_name='spec2006-ncore'

    def setUp(self):
        pass

    def tearDown(self):
        pass

    # 测试函数
    def test_spec2006_ncore_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_spec2006_ncore_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_spec2006_ncore_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)



#==============================================================
#TestCase: runltp
class runltp(unittest.TestCase):

    case_name='runltp'

    def setUp(self):
        pass

    def tearDown(self):
        pass

    # 测试函数
    def test_runltp_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_runltp_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_runltp_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)


#==============================================================
#TestCase: scp-BigFile(其实是scp大文件夹,不是单个大文件)
class scp_BigDir(unittest.TestCase):

    case_name='scp-BigFile'

    def setUp(self):
        pass

    def tearDown(self):
        pass

    # 测试函数
    def test_scp_BigDir_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_scp_BigDir_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_scp_BigDir_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)


#==============================================================
#TestCase: ltpstress
class ltpstress(unittest.TestCase):

    case_name='ltpstress'

    def setUp(self):
        pass

    def tearDown(self):
        pass

    # 测试函数
    def test_ltpstress_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_ltpstress_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_ltpstress_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)


#==============================================================
#TestCase: IOstress
class IOstress(unittest.TestCase):

    case_name='IOstress'

    def setUp(self):
        pass

    def tearDown(self):
        pass

    # 测试函数
    def test_IOstress_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_IOstress_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_IOstress_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)


#==============================================================
