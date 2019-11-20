#!/bin/bash
set -e

#if [ $# -ne 3 ];then
# echo "usage: $0 TestType Platform TestCase" 
# exit 1
#fi

#----------------------------------------------------------------------------------------
TestType="Kernel"
Platform="2K"
#----------------------------------------------------------------------------------------

echo "开始获取测试信息文件:[$TestType],[$Platform]"

#第一组测试
echo "***************************************************"
echo "Group [1]:get test info files"

sh get_TestInfo.sh $TestType $Platform "Compiler"
sh get_TestInfo.sh $TestType $Platform "top"
sh get_TestInfo.sh $TestType $Platform "ps"
sh get_TestInfo.sh $TestType $Platform "iostat"
sh get_TestInfo.sh $TestType $Platform "interrupts"
sh get_TestInfo.sh $TestType $Platform "getrandom"
sh get_TestInfo.sh $TestType $Platform "ring-test"
sh get_TestInfo.sh $TestType $Platform "unalign"
sh get_TestInfo.sh $TestType $Platform "kernel_madd_support_check"
sh get_TestInfo.sh $TestType $Platform "audit-write"
sh get_TestInfo.sh $TestType $Platform "auditctl"
sh get_TestInfo.sh $TestType $Platform "cpu_occupy"
sh get_TestInfo.sh $TestType $Platform "kernel_interrupts_count"
sh get_TestInfo.sh $TestType $Platform "kernel_ll_sc"
sh get_TestInfo.sh $TestType $Platform "unaligned_instructions"
sh get_TestInfo.sh $TestType $Platform "fpuemustats"
sh get_TestInfo.sh $TestType $Platform "compiler_ll_sc"
sh get_TestInfo.sh $TestType $Platform "filesystem_ll_sc"

sh get_TestInfo.sh $TestType $Platform "arpd"
sh get_TestInfo.sh $TestType $Platform "bridge"
sh get_TestInfo.sh $TestType $Platform "cbq"
sh get_TestInfo.sh $TestType $Platform "net_service"
sh get_TestInfo.sh $TestType $Platform "net_setting"

sh get_TestInfo.sh $TestType $Platform "c"
sh get_TestInfo.sh $TestType $Platform "c++"
sh get_TestInfo.sh $TestType $Platform "java"
sh get_TestInfo.sh $TestType $Platform "lua"
sh get_TestInfo.sh $TestType $Platform "perl"
sh get_TestInfo.sh $TestType $Platform "php"
sh get_TestInfo.sh $TestType $Platform "ruby"
sh get_TestInfo.sh $TestType $Platform "go"

sh get_TestInfo.sh $TestType $Platform "docker_search_pull_start"
sh get_TestInfo.sh $TestType $Platform "run_stop_rm"
sh get_TestInfo.sh $TestType $Platform "container_export_import"
sh get_TestInfo.sh $TestType $Platform "images_export_import"
sh get_TestInfo.sh $TestType $Platform "docker_namespace-net"
sh get_TestInfo.sh $TestType $Platform "docker_namespace-pid"
sh get_TestInfo.sh $TestType $Platform "docker_log"
sh get_TestInfo.sh $TestType $Platform "docker_rmi"

sh get_TestInfo.sh $TestType $Platform "rpm_list_check"
sh get_TestInfo.sh $TestType $Platform "rpm_installed_check"
sh get_TestInfo.sh $TestType $Platform "rpm_list_info_check"
sh get_TestInfo.sh $TestType $Platform "rpm_installed_info_check"

sh get_TestInfo.sh $TestType $Platform "luajit"
sh get_TestInfo.sh $TestType $Platform "crond"

sh get_TestInfo.sh $TestType $Platform "ethtool"
sh get_TestInfo.sh $TestType $Platform "mii-tool"
sh get_TestInfo.sh $TestType $Platform "mongodb"

sh get_TestInfo.sh $TestType $Platform "ping"
sh get_TestInfo.sh $TestType $Platform "wget"
sh get_TestInfo.sh $TestType $Platform "iozone"
sh get_TestInfo.sh $TestType $Platform "disk_unzip_copy"
sh get_TestInfo.sh $TestType $Platform "netperf"

echo "***************************************************"

#第二组测试
echo "***************************************************"
echo "Group [2]:get test info files"

sh get_TestInfo.sh $TestType $Platform "netperf_direct"
sh get_TestInfo.sh $TestType $Platform "scp-dir"
sh get_TestInfo.sh $TestType $Platform "lmbench"
sh get_TestInfo.sh $TestType $Platform "stream"
sh get_TestInfo.sh $TestType $Platform "UnixBench"
sh get_TestInfo.sh $TestType $Platform "stressapp"

echo "***************************************************"

#第三组测试
echo "***************************************************"
echo "Group [3]:get test info files"

sh get_TestInfo.sh $TestType $Platform "scp-2"
sh get_TestInfo.sh $TestType $Platform "scp-1"
sh get_TestInfo.sh $TestType $Platform "spec2000-1core"
sh get_TestInfo.sh $TestType $Platform "spec2000-ncore"

echo "***************************************************"

#第四组测试
echo "***************************************************"
echo "Group [4]:get test info files"

sh get_TestInfo.sh $TestType $Platform "spec2006-1core"
sh get_TestInfo.sh $TestType $Platform "spec2006-ncore"

echo "***************************************************"

#第五组测试
echo "***************************************************"
echo "Group [5]:get test info files"
echo "***************************************************"

#第六组测试
echo "***************************************************"
echo "Group [6]:get test info files"

sh get_TestInfo.sh $TestType $Platform "runltp"

echo "***************************************************"

#第七组测试
echo "***************************************************"
echo "Group [7]:get test info files"
echo "***************************************************"

#第八组测试
echo "***************************************************"
echo "Group [8]:get test info files"

sh get_TestInfo.sh $TestType $Platform "scp-BigFile"

echo "***************************************************"

#第九组测试
echo "***************************************************"
echo "Group [9]:get test info files"

sh get_TestInfo.sh $TestType $Platform "ltpstress"

echo "***************************************************"


echo "***************************************************"

#第十组测试
echo "***************************************************"
echo "Group [10]:get test info files"

sh get_TestInfo.sh $TestType $Platform "IOstress"

echo "***************************************************"
