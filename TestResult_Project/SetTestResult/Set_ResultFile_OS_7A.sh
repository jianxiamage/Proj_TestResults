#!/bin/bash

#if [ $# -ne 3 ];then
# echo "usage: $0 TestType Platform TestCase" 
# exit 1
#fi

#----------------------------------------------------------------------------------------
TestType="OS"
Platform="7A"
#----------------------------------------------------------------------------------------

echo "开始获取测试结果跑分文件:[$TestType],[$Platform]"

#第一组测试
echo "***************************************************"
echo "Group [1]:set test result info to config file"

sh set_result_tag.sh $TestType $Platform "ping"
sh set_result_tag.sh $TestType $Platform "wget"
sh set_result_tag.sh $TestType $Platform "iozone"
sh set_result_tag.sh $TestType $Platform "disk_unzip_copy"
sh set_result_tag.sh $TestType $Platform "netperf"
sh set_result_tag.sh $TestType $Platform "BasicSystemInfo"

echo "***************************************************"

#第二组测试
echo "***************************************************"
echo "Group [2]:set test result info to config file"

sh set_result_tag.sh $TestType $Platform "netperf-direct"
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

#第十五组测试
echo "***************************************************"
echo "Group [15]:set test result info to config file"

sh set_result_tag.sh $TestType $Platform "gcc"
sh set_result_tag.sh $TestType $Platform "glibc"
sh set_result_tag.sh $TestType $Platform "binutils"
sh set_result_tag.sh $TestType $Platform "openSSL"
sh set_result_tag.sh $TestType $Platform "SpecJvm2008"

echo "***************************************************"
