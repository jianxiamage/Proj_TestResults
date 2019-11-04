#!/bin/bash
set -e

#if [ $# -ne 3 ];then
# echo "usage: $0 TestType Platform TestCase" 
# exit 1
#fi

#----------------------------------------------------------------------------------------
TestType="Kernel"
Platform="7A"
#----------------------------------------------------------------------------------------

echo "开始获取测试结果跑分文件:[$TestType],[$Platform]"

#第一组测试
echo "***************************************************"
echo "Group [1]:set test result info to config file"

sh set_result_tag.sh $TestType $Platform "Compiler"
sh set_result_tag.sh $TestType $Platform "top"
sh set_result_tag.sh $TestType $Platform "ps"
sh set_result_tag.sh $TestType $Platform "iostat"
sh set_result_tag.sh $TestType $Platform "interrupts"
sh set_result_tag.sh $TestType $Platform "getrandom"
sh set_result_tag.sh $TestType $Platform "ring-test"
sh set_result_tag.sh $TestType $Platform "unalign"
sh set_result_tag.sh $TestType $Platform "kernel_madd_support_check"
sh set_result_tag.sh $TestType $Platform "audit-write"
sh set_result_tag.sh $TestType $Platform "auditctl"
sh set_result_tag.sh $TestType $Platform "cpu_occupy"
sh set_result_tag.sh $TestType $Platform "kernel_interrupts_count"
sh set_result_tag.sh $TestType $Platform "kernel_ll_sc"
sh set_result_tag.sh $TestType $Platform "unaligned_instructions"
sh set_result_tag.sh $TestType $Platform "fpuemustats"
sh set_result_tag.sh $TestType $Platform "compiler_ll_sc"
sh set_result_tag.sh $TestType $Platform "filesystem_ll_sc"

sh set_result_tag.sh $TestType $Platform "docker_search_pull_start"
sh set_result_tag.sh $TestType $Platform "run_stop_rm"
sh set_result_tag.sh $TestType $Platform "container_export_import"
sh set_result_tag.sh $TestType $Platform "images_export_import"
sh set_result_tag.sh $TestType $Platform "namespace-net"
sh set_result_tag.sh $TestType $Platform "namespace-pid"
sh set_result_tag.sh $TestType $Platform "docker_log"
sh set_result_tag.sh $TestType $Platform "docker_rmi"

sh set_result_tag.sh $TestType $Platform "rpm_list_check"
sh set_result_tag.sh $TestType $Platform "rpm_installed_check"
sh set_result_tag.sh $TestType $Platform "rpm_list_info_check"
sh set_result_tag.sh $TestType $Platform "rpm_installed_info_check"

sh set_result_tag.sh $TestType $Platform "test_lua"

sh set_result_tag.sh $TestType $Platform "ping"
sh set_result_tag.sh $TestType $Platform "wget"
sh set_result_tag.sh $TestType $Platform "iozone"
sh set_result_tag.sh $TestType $Platform "disk_unzip_copy"
sh set_result_tag.sh $TestType $Platform "netperf"

echo "***************************************************"

#第二组测试
echo "***************************************************"
echo "Group [2]:set test result info to config file"

sh set_result_tag.sh $TestType $Platform "netperf_direct"
sh set_result_tag.sh $TestType $Platform "scp-dir"
sh set_result_tag.sh $TestType $Platform "lmbench"
sh set_result_tag.sh $TestType $Platform "stream"
sh set_result_tag.sh $TestType $Platform "UnixBench"
sh set_result_tag.sh $TestType $Platform "stressapp"

echo "***************************************************"

#第三组测试
echo "***************************************************"
echo "Group [3]:set test result info to config file"

sh set_result_tag.sh $TestType $Platform "scp-2"
sh set_result_tag.sh $TestType $Platform "scp-1"
sh set_result_tag.sh $TestType $Platform "spec2000-1core"
sh set_result_tag.sh $TestType $Platform "spec2000-ncore"

echo "***************************************************"

#第四组测试
echo "***************************************************"
echo "Group [4]:set test result info to config file"

sh set_result_tag.sh $TestType $Platform "spec2006-1core"
sh set_result_tag.sh $TestType $Platform "spec2006-ncore"

echo "***************************************************"

#第五组测试
echo "***************************************************"
echo "Group [5]:set test result info to config file"
echo "***************************************************"

#第六组测试
echo "***************************************************"
echo "Group [6]:set test result info to config file"

sh set_result_tag.sh $TestType $Platform "runltp"

echo "***************************************************"

#第七组测试
echo "***************************************************"
echo "Group [7]:set test result info to config file"
echo "***************************************************"

#第八组测试
echo "***************************************************"
echo "Group [8]:set test result info to config file"

sh set_result_tag.sh $TestType $Platform "scp-BigFile"

echo "***************************************************"

#第九组测试
echo "***************************************************"
echo "Group [9]:set test result info to config file"

sh set_result_tag.sh $TestType $Platform "ltpstress"

echo "***************************************************"


echo "***************************************************"

#第十组测试
echo "***************************************************"
echo "Group [10]:set test result info to config file"

sh set_result_tag.sh $TestType $Platform "IOstress"

echo "***************************************************"
