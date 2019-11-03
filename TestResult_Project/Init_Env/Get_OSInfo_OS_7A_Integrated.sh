#!/bin/bash

#if [ $# -ne 3 ];then
# echo "usage: $0 TestType Platform TestCase" 
# exit 1
#fi

#----------------------------------------------------------------------------------------
TestType="OS"
Platform="7A_Integrated"
#----------------------------------------------------------------------------------------

echo "开始获取测试节点系统信息文件:[$TestType],[$Platform]"

#第一组测试
echo "***************************************************"
echo "Group [1]:get the os info of the nodes"

sh get_DetailInfo.sh $TestType $Platform "Compiler"
sh get_DetailInfo.sh $TestType $Platform "top"
sh get_DetailInfo.sh $TestType $Platform "ps"
sh get_DetailInfo.sh $TestType $Platform "iostat"
sh get_DetailInfo.sh $TestType $Platform "interrupts"
sh get_DetailInfo.sh $TestType $Platform "getrandom"
sh get_DetailInfo.sh $TestType $Platform "ring-test"
sh get_DetailInfo.sh $TestType $Platform "unalign"
sh get_DetailInfo.sh $TestType $Platform "kernel_madd_support_check"
sh get_DetailInfo.sh $TestType $Platform "audit-write"
sh get_DetailInfo.sh $TestType $Platform "auditctl"
sh get_DetailInfo.sh $TestType $Platform "cpu_occupy"
sh get_DetailInfo.sh $TestType $Platform "kernel_interrupts_count"
sh get_DetailInfo.sh $TestType $Platform "kernel_ll_sc"
sh get_DetailInfo.sh $TestType $Platform "unaligned_instructions"
sh get_DetailInfo.sh $TestType $Platform "fpuemustats"
sh get_DetailInfo.sh $TestType $Platform "compiler_ll_sc"
sh get_DetailInfo.sh $TestType $Platform "filesystem_ll_sc"

sh get_DetailInfo.sh $TestType $Platform "docker_search_pull_start"
sh get_DetailInfo.sh $TestType $Platform "run_stop_rm"
sh get_DetailInfo.sh $TestType $Platform "container_export_import"
sh get_DetailInfo.sh $TestType $Platform "images_export_import"
sh get_DetailInfo.sh $TestType $Platform "namespace-net"
sh get_DetailInfo.sh $TestType $Platform "namespace-pid"
sh get_DetailInfo.sh $TestType $Platform "docker_log"
sh get_DetailInfo.sh $TestType $Platform "docker_rmi"

sh get_DetailInfo.sh $TestType $Platform "rpm_list_check"
sh get_DetailInfo.sh $TestType $Platform "rpm_installed_check"
sh get_DetailInfo.sh $TestType $Platform "rpm_list_info_check"
sh get_DetailInfo.sh $TestType $Platform "rpm_installed_info_check"

sh get_DetailInfo.sh $TestType $Platform "test_lua"


sh get_DetailInfo.sh $TestType $Platform "ping"
sh get_DetailInfo.sh $TestType $Platform "wget"
sh get_DetailInfo.sh $TestType $Platform "iozone"
sh get_DetailInfo.sh $TestType $Platform "disk_unzip_copy"
sh get_DetailInfo.sh $TestType $Platform "netperf"

echo "***************************************************"

#第二组测试
echo "***************************************************"
echo "Group [2]:get the os info of the nodes"

sh get_DetailInfo.sh $TestType $Platform "netperf-direct"
sh get_DetailInfo.sh $TestType $Platform "scp-dir"
sh get_DetailInfo.sh $TestType $Platform "lmbench"
sh get_DetailInfo.sh $TestType $Platform "stream"
sh get_DetailInfo.sh $TestType $Platform "UnixBench"
sh get_DetailInfo.sh $TestType $Platform "stressapp"

echo "***************************************************"

#第三组测试
echo "***************************************************"
echo "Group [3]:get the os info of the nodes"

sh get_DetailInfo.sh $TestType $Platform "scp-2"
sh get_DetailInfo.sh $TestType $Platform "scp-1"
sh get_DetailInfo.sh $TestType $Platform "spec2000-1core"
sh get_DetailInfo.sh $TestType $Platform "spec2000-ncore"

echo "***************************************************"

#第四组测试
echo "***************************************************"
echo "Group [4]:get the os info of the nodes"

sh get_DetailInfo.sh $TestType $Platform "spec2006-1core"
sh get_DetailInfo.sh $TestType $Platform "spec2006-ncore"

echo "***************************************************"

#第五组测试
echo "***************************************************"
echo "Group [5]:get the os info of the nodes"
echo "***************************************************"

#第六组测试
echo "***************************************************"
echo "Group [6]:get the os info of the nodes"

sh get_DetailInfo.sh $TestType $Platform "runltp"

echo "***************************************************"

#第七组测试
echo "***************************************************"
echo "Group [7]:get the os info of the nodes"
echo "***************************************************"

#第八组测试
echo "***************************************************"
echo "Group [8]:get the os info of the nodes"

sh get_DetailInfo.sh $TestType $Platform "scp-BigFile"

echo "***************************************************"

#第九组测试
echo "***************************************************"
echo "Group [9]:get the os info of the nodes"

sh get_DetailInfo.sh $TestType $Platform "ltpstress"

echo "***************************************************"


echo "***************************************************"

#第十组测试
echo "***************************************************"
echo "Group [10]:get the os info of the nodes"

sh get_DetailInfo.sh $TestType $Platform "IOstress"

echo "***************************************************"

#第十五组测试
echo "***************************************************"
echo "Group [15]:get the os info of the nodes"

sh get_DetailInfo.sh $TestType $Platform "gcc"
sh get_DetailInfo.sh $TestType $Platform "glibc"
sh get_DetailInfo.sh $TestType $Platform "binutils"
sh get_DetailInfo.sh $TestType $Platform "openSSL"
sh get_DetailInfo.sh $TestType $Platform "SpecJvm2008"

echo "***************************************************"
