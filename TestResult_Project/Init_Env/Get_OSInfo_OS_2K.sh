#!/bin/bash

#if [ $# -ne 3 ];then
# echo "usage: $0 TestType Platform TestCase" 
# exit 1
#fi

#----------------------------------------------------------------------------------------
TestType="OS"
Platform="2K"
#----------------------------------------------------------------------------------------

echo "开始获取测试节点系统信息文件:[$TestType],[$Platform]"

#第一组测试
echo "***************************************************"
echo "Group [1]:get the os info of the nodes"

sh get_DetailInfo.sh $TestType $Platform "ping"
sh get_DetailInfo.sh $TestType $Platform "wget"
sh get_DetailInfo.sh $TestType $Platform "iozone"
sh get_DetailInfo.sh $TestType $Platform "disk_unzip_copy"
sh get_DetailInfo.sh $TestType $Platform "netperf"
sh get_DetailInfo.sh $TestType $Platform "BasicSystemInfo"

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
