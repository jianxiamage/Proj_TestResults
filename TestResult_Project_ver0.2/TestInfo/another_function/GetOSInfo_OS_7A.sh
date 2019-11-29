#!/bin/bash
#set -e

#if [ $# -ne 3 ];then
# echo "usage: $0 TestType Platform TestCase" 
# exit 1
#fi

#----------------------------------------------------------------------------------------
TestType="OS"
Platform="7A"
#----------------------------------------------------------------------------------------

echo "开始获取测试信息文件:[$TestType],[$Platform]"

#第一组测试
echo "***************************************************"
echo "Group [1]:get OS info files"

sh get_OSInfo.sh $TestType $Platform "Compiler"
sh get_OSInfo.sh $TestType $Platform "top"
sh get_OSInfo.sh $TestType $Platform "ps"
sh get_OSInfo.sh $TestType $Platform "iostat"
sh get_OSInfo.sh $TestType $Platform "interrupts"
sh get_OSInfo.sh $TestType $Platform "getrandom"
sh get_OSInfo.sh $TestType $Platform "ring-test"
sh get_OSInfo.sh $TestType $Platform "unalign"
sh get_OSInfo.sh $TestType $Platform "kernel_madd_support_check"
sh get_OSInfo.sh $TestType $Platform "audit-write"
sh get_OSInfo.sh $TestType $Platform "auditctl"
sh get_OSInfo.sh $TestType $Platform "cpu_occupy"
sh get_OSInfo.sh $TestType $Platform "kernel_interrupts_count"
sh get_OSInfo.sh $TestType $Platform "kernel_ll_sc"
sh get_OSInfo.sh $TestType $Platform "unaligned_instructions"
sh get_OSInfo.sh $TestType $Platform "fpuemustats"
sh get_OSInfo.sh $TestType $Platform "compiler_ll_sc"
sh get_OSInfo.sh $TestType $Platform "filesystem_ll_sc"

sh get_OSInfo.sh $TestType $Platform "arpd"
sh get_OSInfo.sh $TestType $Platform "bridge"
sh get_OSInfo.sh $TestType $Platform "cbq"
sh get_OSInfo.sh $TestType $Platform "net_service"
sh get_OSInfo.sh $TestType $Platform "net_setting"

sh get_OSInfo.sh $TestType $Platform "c"
sh get_OSInfo.sh $TestType $Platform "c++"
sh get_OSInfo.sh $TestType $Platform "java"
sh get_OSInfo.sh $TestType $Platform "lua"
sh get_OSInfo.sh $TestType $Platform "perl"
sh get_OSInfo.sh $TestType $Platform "php"
sh get_OSInfo.sh $TestType $Platform "ruby"
sh get_OSInfo.sh $TestType $Platform "go"

sh get_OSInfo.sh $TestType $Platform "docker_search_pull_start"
sh get_OSInfo.sh $TestType $Platform "run_stop_rm"
sh get_OSInfo.sh $TestType $Platform "container_export_import"
sh get_OSInfo.sh $TestType $Platform "images_export_import"
sh get_OSInfo.sh $TestType $Platform "docker_namespace_net"
sh get_OSInfo.sh $TestType $Platform "docker_namespace_pid"
sh get_OSInfo.sh $TestType $Platform "docker_log"
sh get_OSInfo.sh $TestType $Platform "docker_rmi"

sh get_OSInfo.sh $TestType $Platform "rpm_list_check"
sh get_OSInfo.sh $TestType $Platform "rpm_installed_check"
sh get_OSInfo.sh $TestType $Platform "rpm_list_info_check"
sh get_OSInfo.sh $TestType $Platform "rpm_installed_info_check"

sh get_OSInfo.sh $TestType $Platform "luajit"
sh get_OSInfo.sh $TestType $Platform "crond"

sh get_OSInfo.sh $TestType $Platform "ethtool"
sh get_OSInfo.sh $TestType $Platform "mii-tool"
sh get_OSInfo.sh $TestType $Platform "mongodb"

sh get_OSInfo.sh $TestType $Platform "ping"
sh get_OSInfo.sh $TestType $Platform "wget"
sh get_OSInfo.sh $TestType $Platform "iozone"
sh get_OSInfo.sh $TestType $Platform "disk_unzip_copy"
sh get_OSInfo.sh $TestType $Platform "netperf"

echo "***************************************************"

#第二组测试
echo "***************************************************"
echo "Group [2]:get os info files"

sh get_OSInfo.sh $TestType $Platform "netperf_direct"
sh get_OSInfo.sh $TestType $Platform "scp-dir"
sh get_OSInfo.sh $TestType $Platform "lmbench"
sh get_OSInfo.sh $TestType $Platform "stream"
sh get_OSInfo.sh $TestType $Platform "UnixBench"
sh get_OSInfo.sh $TestType $Platform "stressapp"

echo "***************************************************"

#第三组测试
echo "***************************************************"
echo "Group [3]:get os info files"

sh get_OSInfo.sh $TestType $Platform "scp-2"
sh get_OSInfo.sh $TestType $Platform "scp-1"
sh get_OSInfo.sh $TestType $Platform "spec2000-1core"
sh get_OSInfo.sh $TestType $Platform "spec2000-ncore"

echo "***************************************************"

#第四组测试
echo "***************************************************"
echo "Group [4]:get os info files"

sh get_OSInfo.sh $TestType $Platform "spec2006-1core"
sh get_OSInfo.sh $TestType $Platform "spec2006-ncore"

echo "***************************************************"

#第五组测试
echo "***************************************************"
echo "Group [5]:get os info files"
echo "***************************************************"

#第六组测试
echo "***************************************************"
echo "Group [6]:get os info files"

sh get_OSInfo.sh $TestType $Platform "runltp"

echo "***************************************************"

#第七组测试
echo "***************************************************"
echo "Group [7]:get os info files"
echo "***************************************************"

#第八组测试
echo "***************************************************"
echo "Group [8]:get os info files"

sh get_OSInfo.sh $TestType $Platform "scp-BigFile"

echo "***************************************************"

#第九组测试
echo "***************************************************"
echo "Group [9]:get os info files"

sh get_OSInfo.sh $TestType $Platform "ltpstress"

echo "***************************************************"


echo "***************************************************"

#第十组测试
echo "***************************************************"
echo "Group [10]:get os info files"

sh get_OSInfo.sh $TestType $Platform "IOstress"

echo "***************************************************"
#第十五组测试
echo "***************************************************"
echo "Group [15]:get os info files"

sh get_OSInfo.sh $TestType $Platform "gcc"
sh get_OSInfo.sh $TestType $Platform "glibc"
sh get_OSInfo.sh $TestType $Platform "binutils"
sh get_OSInfo.sh $TestType $Platform "openSSL"
sh get_OSInfo.sh $TestType $Platform "SpecJvm2008"

echo "***************************************************"

