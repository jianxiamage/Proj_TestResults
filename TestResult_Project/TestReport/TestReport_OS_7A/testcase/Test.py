#!/usr/bin/env python
#coding:utf-8

import unittest

from get_test_result import *

#==============================================================
#TestCase: ping

class ping(unittest.TestCase):
    
    case_name='ping'

    def setUp(self):
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

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
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

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
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

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
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

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
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

    # 测试函数
    def test_netperf_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_netperf_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_netperf_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)


#==============================================================
#TestCase: Compiler Test
class Compiler(unittest.TestCase):

    case_name='Compiler'

    def setUp(self):
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

    # 测试函数
    def test_Compiler_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_Compiler_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_Compiler_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)

#==============================================================
#TestCase: top Test
class top(unittest.TestCase):

    case_name='top'

    def setUp(self):
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

    # 测试函数
    def test_top_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_top_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_top_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)


#==============================================================
#TestCase: ps Test
class ps(unittest.TestCase):

    case_name='ps'

    def setUp(self):
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

    # 测试函数
    def test_ps_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_ps_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_ps_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)

#==============================================================
#TestCase: iostat Test
class iostat(unittest.TestCase):

    case_name='iostat'

    def setUp(self):
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

    # 测试函数
    def test_iostat_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_iostat_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_iostat_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)

#==============================================================
#TestCase: interrupts Test
class interrupts(unittest.TestCase):

    case_name='interrupts'

    def setUp(self):
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

    # 测试函数
    def test_interrupts_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_interrupts_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_interrupts_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)

#==============================================================
#TestCase: getrandom Test
class getrandom(unittest.TestCase):

    case_name='getrandom'

    def setUp(self):
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

    # 测试函数
    def test_getrandom_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_getrandom_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_getrandom_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)

#==============================================================
#TestCase: ring-test Test
class ring_test(unittest.TestCase):

    case_name='ring-test'

    def setUp(self):
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

    # 测试函数
    def test_ring_test_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_ring_test_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_ring_test_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)

#==============================================================
#TestCase: unalign Test
class unalign(unittest.TestCase):

    case_name='unalign'

    def setUp(self):
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

    # 测试函数
    def test_unalign_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_unalign_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_unalign_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)

#==============================================================
#TestCase: kernel_madd_support_check Test
class kernel_madd_support_check(unittest.TestCase):

    case_name='kernel_madd_support_check'

    def setUp(self):
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

    # 测试函数
    def test_kernel_madd_support_check_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_kernel_madd_support_check_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_kernel_madd_support_check_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)

#==============================================================
#TestCase: audit-write Test
class audit_write(unittest.TestCase):

    case_name='audit-write'

    def setUp(self):
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

    # 测试函数
    def test_audit_write_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_audit_write_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_audit_write_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)

#==============================================================
#TestCase: auditctl Test
class auditctl(unittest.TestCase):

    case_name='auditctl'

    def setUp(self):
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

    # 测试函数
    def test_auditctl_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_auditctl_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_auditctl_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)

#==============================================================
#TestCase: cpu_occupy Test
class cpu_occupy(unittest.TestCase):

    case_name='cpu_occupy'

    def setUp(self):
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

    # 测试函数
    def test_cpu_occupy_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_cpu_occupy_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_cpu_occupy_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)

#==============================================================
#TestCase: kernel_interrupts_count Test
class kernel_interrupts_count(unittest.TestCase):

    case_name='kernel_interrupts_count'

    def setUp(self):
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

    # 测试函数
    def test_kernel_interrupts_count_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_kernel_interrupts_count_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_kernel_interrupts_count_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)

#==============================================================
#TestCase: kernel_ll_sc Test
class kernel_ll_sc(unittest.TestCase):

    case_name='kernel_ll_sc'

    def setUp(self):
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

    # 测试函数
    def test_kernel_ll_sc_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_kernel_ll_sc_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_kernel_ll_sc_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)

#==============================================================
#TestCase: unaligned_instructions Test
class unaligned_instructions(unittest.TestCase):

    case_name='unaligned_instructions'

    def setUp(self):
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

    # 测试函数
    def test_unaligned_instructions_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_unaligned_instructions_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_unaligned_instructions_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)

#==============================================================
#TestCase: fpuemustats Test
class fpuemustats(unittest.TestCase):

    case_name='fpuemustats'

    def setUp(self):
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

    # 测试函数
    def test_fpuemustats_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_fpuemustats_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_fpuemustats_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)

#==============================================================
#TestCase: compiler_ll_sc Test
class compiler_ll_sc(unittest.TestCase):

    case_name='compiler_ll_sc'

    def setUp(self):
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

    # 测试函数
    def test_compiler_ll_sc_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_compiler_ll_sc_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_compiler_ll_sc_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)

#==============================================================
#TestCase: filesystem_ll_sc Test
class filesystem_ll_sc(unittest.TestCase):

    case_name='filesystem_ll_sc'

    def setUp(self):
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

    # 测试函数
    def test_filesystem_ll_sc_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_filesystem_ll_sc_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_filesystem_ll_sc_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)

#==============================================================
#TestCase: c

class c(unittest.TestCase):

    case_name='c'

    def setUp(self):
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

    # 测试函数
    def test_c_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_c_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_c_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)

#==============================================================
#TestCase: cplusplus

class cplusplus(unittest.TestCase):

    case_name='c++'

    def setUp(self):
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

    # 测试函数
    def test_cplusplus_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_cplusplus_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_cplusplus_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)

#==============================================================
#TestCase: java

class java(unittest.TestCase):

    case_name='java'

    def setUp(self):
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

    # 测试函数
    def test_java_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_java_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_java_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)

#==============================================================
#TestCase: lua

class lua(unittest.TestCase):

    case_name='lua'

    def setUp(self):
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

    # 测试函数
    def test_lua_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_lua_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_lua_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)

#==============================================================
#TestCase: perl

class perl(unittest.TestCase):

    case_name='perl'

    def setUp(self):
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

    # 测试函数
    def test_perl_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_perl_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_perl_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)

#==============================================================
#TestCase: php

class php(unittest.TestCase):

    case_name='php'

    def setUp(self):
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

    # 测试函数
    def test_php_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_php_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_php_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)

#==============================================================
#TestCase: ruby

class ruby(unittest.TestCase):

    case_name='ruby'

    def setUp(self):
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

    # 测试函数
    def test_ruby_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_ruby_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_ruby_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)

#==============================================================
#TestCase: go

class go(unittest.TestCase):

    case_name='go'

    def setUp(self):
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

    # 测试函数
    def test_go_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_go_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_go_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)

#==============================================================
#TestCase: docker_search_pull_start Test
class docker_search_pull_start(unittest.TestCase):

    case_name='docker_search_pull_start'

    def setUp(self):
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

    # 测试函数
    def test_docker_search_pull_start_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_docker_search_pull_start_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_docker_search_pull_start_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)

#==============================================================
#TestCase: run_stop_rm Test
class run_stop_rm(unittest.TestCase):

    case_name='run_stop_rm'

    def setUp(self):
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

    # 测试函数
    def test_run_stop_rm_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_run_stop_rm_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_run_stop_rm_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)

#==============================================================
#TestCase: container_export_import Test
class container_export_import(unittest.TestCase):

    case_name='container_export_import'

    def setUp(self):
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

    # 测试函数
    def test_container_export_import_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_container_export_import_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_container_export_import_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)

#==============================================================
#TestCase: images_export_import Test
class images_export_import(unittest.TestCase):

    case_name='images_export_import'

    def setUp(self):
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

    # 测试函数
    def test_images_export_import_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_images_export_import_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_images_export_import_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)

#==============================================================
#TestCase: docker_namespace_net Test
class docker_namespace_net(unittest.TestCase):

    case_name='docker_namespace_net'

    def setUp(self):
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

    # 测试函数
    def test_docker_namespace_net_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_docker_namespace_net_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_docker_namespace_net_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)

#==============================================================
#TestCase: docker_namespace_pid Test
class docker_namespace_pid(unittest.TestCase):

    case_name='docker_namespace_pid'

    def setUp(self):
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

    # 测试函数
    def test_docker_namespace_pid_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_docker_namespace_pid_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_docker_namespace_pid_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)

#==============================================================
#TestCase: docker_log Test
class docker_log(unittest.TestCase):

    case_name='docker_log'

    def setUp(self):
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

    # 测试函数
    def test_docker_log_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_docker_log_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_docker_log_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)

#==============================================================
#TestCase: docker_rmi Test
class docker_rmi(unittest.TestCase):

    case_name='docker_rmi'

    def setUp(self):
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

    # 测试函数
    def test_docker_rmi_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_docker_rmi_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_docker_rmi_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)

#==============================================================
#TestCase: rpm_list_check Test
class rpm_list_check(unittest.TestCase):

    case_name='rpm_list_check'

    def setUp(self):
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

    # 测试函数
    def test_rpm_list_check_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_rpm_list_check_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_rpm_list_check_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)

#==============================================================
#TestCase: rpm_installed_check Test
class rpm_installed_check(unittest.TestCase):

    case_name='rpm_installed_check'

    def setUp(self):
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

    # 测试函数
    def test_rpm_installed_check_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_rpm_installed_check_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_rpm_installed_check_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)

#==============================================================
#TestCase: rpm_list_info_check Test
class rpm_list_info_check(unittest.TestCase):

    case_name='rpm_list_info_check'

    def setUp(self):
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

    # 测试函数
    def test_rpm_list_info_check_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_rpm_list_info_check_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_rpm_list_info_check_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)

#==============================================================
#TestCase: rpm_installed_info_check Test
class rpm_installed_info_check(unittest.TestCase):

    case_name='rpm_installed_info_check'

    def setUp(self):
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

    # 测试函数
    def test_rpm_installed_info_check_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_rpm_installed_info_check_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_rpm_installed_info_check_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)

#==============================================================
#TestCase: luajit Test
class luajit(unittest.TestCase):

    case_name='luajit'

    def setUp(self):
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

    # 测试函数
    def test_luajit_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_luajit_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_luajit_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)

#==============================================================
#TestCase: crond Test
class crond(unittest.TestCase):

    case_name='crond'

    def setUp(self):
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

    # 测试函数
    def test_crond_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_crond_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_crond_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)

#==============================================================
#TestCase: ethtool Test
class ethtool(unittest.TestCase):

    case_name='ethtool'

    def setUp(self):
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

    # 测试函数
    def test_ethtool_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_ethtool_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_ethtool_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)

#==============================================================
#TestCase: mii_tool Test
class mii_tool(unittest.TestCase):

    case_name='mii-tool'

    def setUp(self):
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

    # 测试函数
    def test_mii_tool_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_mii_tool_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_mii_tool_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)

#==============================================================
#TestCase: mongodb Test
class mongodb(unittest.TestCase):

    case_name='mongodb'

    def setUp(self):
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

    # 测试函数
    def test_mongodb_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_mongodb_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_mongodb_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)

#==============================================================
#TestCase: arpd Test
class arpd(unittest.TestCase):

    case_name='arpd'

    def setUp(self):
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

    # 测试函数
    def test_arpd_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_arpd_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_arpd_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)

#==============================================================
#TestCase: bridge Test
class bridge(unittest.TestCase):

    case_name='bridge'

    def setUp(self):
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

    # 测试函数
    def test_bridge_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_bridge_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_bridge_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)

#==============================================================
#TestCase: cbq Test
class cbq(unittest.TestCase):

    case_name='cbq'

    def setUp(self):
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

    # 测试函数
    def test_cbq_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_cbq_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_cbq_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)

#==============================================================
#TestCase: net_service Test
class net_service(unittest.TestCase):

    case_name='net_service'

    def setUp(self):
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

    # 测试函数
    def test_net_service_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_net_service_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_net_service_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)

#==============================================================
#TestCase: net_setting Test
class net_setting(unittest.TestCase):

    case_name='net_service'

    def setUp(self):
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

    # 测试函数
    def test_net_setting_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_net_setting_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_net_setting_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)

#==============================================================
#TestCase: netperf_direct
class netperf_direct(unittest.TestCase):

    case_name='netperf_direct'

    def setUp(self):
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

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
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

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
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

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
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

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
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

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
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

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
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

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
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

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
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

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
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

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
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

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
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

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
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

    # 测试函数
    def test_runltp_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_runltp_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_runltp_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)


#==============================================================
#TestCase: scp-BigFile(其实是scp大文件夹,不是单个大文件)
class scp_BigFile(unittest.TestCase):

    case_name='scp-BigFile'

    def setUp(self):
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

    # 测试函数
    def test_scp_BigFile_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_scp_BigFile_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_scp_BigFile_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)


#==============================================================
#TestCase: ltpstress
class ltpstress(unittest.TestCase):

    case_name='ltpstress'

    def setUp(self):
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

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
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

    # 测试函数
    def test_IOstress_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_IOstress_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_IOstress_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)

#==============================================================
#TestCase: gcc
class gcc(unittest.TestCase):

    case_name='gcc'

    def setUp(self):
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

    # 测试函数
    def test_gcc_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_gcc_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_gcc_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)

#==============================================================
#TestCase: glibc
class glibc(unittest.TestCase):

    case_name='glibc'

    def setUp(self):
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

    # 测试函数
    def test_glibc_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_glibc_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_glibc_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)


#==============================================================
#TestCase: binutils
class binutils(unittest.TestCase):

    case_name='binutils'

    def setUp(self):
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

    # 测试函数
    def test_binutils_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_binutils_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_binutils_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)


#==============================================================
#TestCase:openSSL 
class openSSL(unittest.TestCase):

    case_name='openSSL'

    def setUp(self):
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

    # 测试函数
    def test_openSSL_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_openSSL_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_openSSL_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)


#==============================================================
#TestCase: SpecJvm2008
class SpecJvm2008(unittest.TestCase):

    case_name='SpecJvm2008'

    def setUp(self):
        print 'setUp...'

    def tearDown(self):
        print 'tearDown...'

    # 测试函数
    def test_SpecJvm2008_Node1(self):
        self.assertEqual(getResult(self.case_name,1) , 0)

    def test_SpecJvm2008_Node2(self):
        self.assertEqual(getResult(self.case_name,2) , 0)

    def test_SpecJvm2008_Node3(self):
        self.assertEqual(getResult(self.case_name,3) , 0)

