#!/bin/bash

########################################################
#功能：
#根据输入参数，备份当前的测试结果到指定的分类目录
#例如:输入参数 OS 7A_2way
#如经过判断，系统类型为:Server,
#则应将其备份至目录:
#/Results/Server/History_Bak/7A_2way/OS
########################################################

#--------------------------------------------
#服务器变量
#--------------------------------------------
ServerIP='auto_test.loongson.cn'
ServerUser='loongson-test'
ServerPass='loongson'
#--------------------------------------------
ServerTestDir='autotest_result'
#--------------------------------------------

#--------------------------------------------
#判断输入参数
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
ResultsPath="/Results"
bakPath="History_Bak"
srcPath="${resultsPath}/${TestType}/${Platform}"
destPath=""
SortPath="UnKnown"
#--------------------------------------------

if [ ! -d ${srcPath} ];
then 
  echo "The src Path is not exists!Please check it."
  exit 1
fi

#------------------------------------------------------------
#获取测试机器的操作系统信息，包括系统类型，系统版本及内核版本
#------------------------------------------------------------
pushd ${OSInfo_Dir}
sh get_OSInfo.sh ${TestType} ${Platform}
if [ $? -ne 0 ];
then
  echo "Get the OS Info failed,Backup failed!exit..." 
  exit 1
fi
popd

#------------------------------------------------------------
os_type=$(cat ${OSInfo_Dir}/${OSTypeFile})
os_ver=$(cat ${OSInfo_Dir}/${OSVerFile})
kernel_ver=$(cat ${OSInfo_Dir}/${KernelVerFile})
#------------------------------------------------------------

#------------------------------------------------------------
#根据测试类型决定备份位置
#------------------------------------------------------------

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

case ${os_type} in

    "Fedora")

        echo "OS Type:${os_type}"
        classify_name='PC'
        SortPath=${classify_name}

        ;;
    "Loongnix-Server")

        echo "Test Type:${TestType}"
        classify_name='Server'
        SortPath=${classify_name}

        ;;

    *)
        echo "Not support the current OS Type:${os_type}"
        exit 1
        ;;
esac


echo "SortPath:${SortPath}"
destPath="${ResultsPath}/${SortPath}/${bakPath}/${Platform}/${TestType}/${BakType}"

echo "destPath for Backup:[${destPath}]"
mkdir $destPath -p

\cp -draf $srcPath/* $destPath
