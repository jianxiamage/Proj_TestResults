#!/bin/bash

#--------------------------------------------
ServerIP='auto_test.loongson.cn'
ServerUser='loongson-test'
ServerPass='loongson'
#--------------------------------------------

ServerTestDir='autotest_result'
#--------------------------------------------

if [ $# -ne 2 ];then
   echo "usage: $0 TestType Platform" 
   exit 0
fi

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
OSInfo_Dir="../Init_Env/OSInfo_Server"
#--------------------------------------------
resultsPath="/data"
ResultsPath="/Results"
bakPath="History_Bak"
srcPath="${resultsPath}/${TestType}/${Platform}"
destPath=""
#--------------------------------------------

if [ ! -d ${srcPath} ];
then 
  echo "The src Path is not exists!Please check it."
  exit 1
fi


#获取测试机器的操作系统信息，包括系统类型，系统版本及内核版本
pushd ${OSInfo_Dir}
sh get_OSInfo.sh ${TestType} ${Platform} top
if [ $? -ne 0 ];
then
  echo "Get the OS Info failed,Backup failed!exit..." 
  exit 1
fi
popd

os_type=$(cat ${OSInfo_Dir}/${OSTypeFile})
os_ver=$(cat ${OSInfo_Dir}/${OSVerFile})
kernel_ver=$(cat ${OSInfo_Dir}/${KernelVerFile})

#SortPath=${os_type}

#根据测试类型决定备份位置

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
    "Loongnix Server")

        echo "Test Type:${TestType}"
        classify_name='Server'
        SortPath=${classify_name}

        ;;

    *)
        echo "Not support the current OS Type:${TestType}"
        exit 1
        ;;
esac


echo "SortPath:${SortPath}"
destPath="${ResultsPath}/${SortPath}/${bakPath}/${Platform}/${BakType}"

echo "destPath for Backup:[${destPath}]"
mkdir $destPath -p

\cp -draf $srcPath/* $destPath
