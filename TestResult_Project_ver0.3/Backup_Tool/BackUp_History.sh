#!/bin/bash

########################################################
#功能：
#根据输入参数，备份当前的测试结果到指定的分类目录
#例如:输入参数 OS 7A_2way
#则将其测试结果完全备份到:/data/OS/History_Bak/7A_2way
########################################################

#--------------------------------------------
#服务器信息变量初始化
#--------------------------------------------
ServerIP='auto_test.loongson.cn'
ServerUser='loongson-test'
ServerPass='loongson'
#--------------------------------------------
ServerTestDir='autotest_result'
#--------------------------------------------

#--------------------------------------------
#判断输入参数个数
#--------------------------------------------
if [ $# -ne 2 ];then
   echo "usage: $0 TestType Platform" 
   exit 0
fi

#--------------------------------------------
#变量初始化
#--------------------------------------------
TestType="$1"
Platform="$2"
#--------------------------------------------
OSTypeFile="OSType_${TestType}_${Platform}.txt"
OSVerFile="OSVer_${TestType}_${Platform}.txt"
KernelVerFile="KernelVer_${TestType}_${Platform}.txt"
#--------------------------------------------
retCode=0
#--------------------------------------------
OSInfo_Dir="../Common_Func/OSInfo_Server"
#--------------------------------------------
resultsPath="/data"
bakPath="History_Bak"
srcPath="${resultsPath}/${TestType}/${Platform}"
destPath="${resultsPath}/${TestType}/${bakPath}/${Platform}"
#--------------------------------------------

if [ ! -d ${srcPath} ];
then 
  echo "The src Path is not exists!Please check it."
  exit 1
fi

#-------------------------------------------------------------------
mkdir $destPath -p

#-------------------------------------------------------------------
#获取测试机器的操作系统信息，包括系统类型，系统版本及内核版本
#-------------------------------------------------------------------
pushd ${OSInfo_Dir}
sh get_OSInfo.sh ${TestType} ${Platform}
if [ $? -ne 0 ];
then
  echo "Get the OS Info failed,Backup failed!exit..." 
  exit 1
fi
popd

os_type=$(cat ${OSInfo_Dir}/${OSTypeFile})
os_ver=$(cat ${OSInfo_Dir}/${OSVerFile})
kernel_ver=$(cat ${OSInfo_Dir}/${KernelVerFile})

#--------------------------------------------
#根据测试类型决定备份位置
#若测试类型为OS,则备份目录为系统版本号
#若测试类型为Kernel,则备份目录为内核版本号
#--------------------------------------------

#--------------------------------------------
#判断测试类型确定备份目录名称
#--------------------------------------------
case ${TestType} in

    "Kernel")

        echo "Test Type:${TestType}"
        BakType=${kernel_ver}        

        ;;
    "OS")

        echo "Test Type:${TestType}"
        BakType=${os_ver}        

        ;;
    "KVM")

        echo "Test Type:${TestType}"
        BakType=${kernel_ver}        

        ;;

    *)
        echo "Not support the current Test Type:${TestType}"
        exit 1
        ;;
esac


#--------------------------------------------
#备份当前的测试结果
#--------------------------------------------
destPath="${resultsPath}/${TestType}/${bakPath}/${Platform}/${BakType}"
echo "destPath for Backup:[${destPath}]"
mkdir $destPath -p
\cp -draf $srcPath/* $destPath
