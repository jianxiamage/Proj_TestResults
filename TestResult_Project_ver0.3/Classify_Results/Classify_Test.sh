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
OSInfo_Dir="../Common_Func/OSInfo_Server"
#--------------------------------------------
dataPath="/data"
ResultsPath="/Results"
SortPath="UnKnown"
srcPath="${dataPath}/${TestType}/${Platform}"
destPath=""
#--------------------------------------------
BasicInfoFile=${srcPath}/BasicInfo.txt
#--------------------------------------------

if [ ! -d ${srcPath} ];
then 
  echo "The src Path is not exists!Please check it."
  exit 1
fi


#获取测试机器的操作系统信息，包括系统类型，系统版本及内核版本
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

#根据测试类型决定备份位置

case ${os_type} in

    "Fedora")

        echo "Test Type:${TestType}"
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

#-------------------------------------------------------------------
MarkTime=$(date "+%Y-%m-%d %H:%M:%S")
echo $MarkTime
#-------------------------------------------------------------------
#记录当前的测试信息到目标目录中，便于简单查看当前的测试情况，如时间，平台等
rm -f $BasicInfoFile

echo MarkTime:[${MarkTime}] > $BasicInfoFile
echo ClassifyType:[${classify_name}] >> $BasicInfoFile
echo TestType:[${TestType}] >> $BasicInfoFile
echo Platform:[${Platform}] >> $BasicInfoFile
echo OS_Type:[${os_type}] >> $BasicInfoFile
echo OS_Ver:[${os_ver}] >> $BasicInfoFile
echo Kernel_Ver:[${kernel_ver}] >> $BasicInfoFile

destPath="${ResultsPath}/${SortPath}/${Platform}/${TestType}"
echo "destPath for Backup:[${destPath}]"

mkdir $destPath -p
\cp -draf $srcPath/* $destPath
