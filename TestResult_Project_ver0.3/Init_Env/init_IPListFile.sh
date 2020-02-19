#!/bin/bash

#-------------------------------------------------------------
IPListFileName='ip_list'
IPListFile='ip_list.ini'

ResultPath='/data'
curIPFilePath='IP_List'

srcPath=''
destPath=''

mkdir $ResultPath -p

TestType=("OS" "Kernel" "KVM")

#--------------------------------------------------------------
#Platform=("7A" "7A_Integrated" "7A_2way" "780" "2K" "3A_4000")
#为便于添加新平台，可以将平台名写入文件中，由程序读取到数组中
#--------------------------------------------------------------
PlatformFile=../Common_Func/PlatformList.txt
echo platform file:$PlatformFile
if [ ! -f "$PlatformFile" ]
then
  echo "$PlatformFile is not exists,Please check it!"
  exit 1
fi

declare -a Platform
Platform=($(cat $PlatformFile))
#--------------------------------------------------------------

#同步服务器上的ip列表文件的目录到本地目录
sh getIPList_fromServer.sh

#-------------------------------------------------------------
for item_type in ${TestType[@]}; do

  #echo $item_type
  echo ----------------------------------------------------

  for item_plat in ${Platform[@]}; do

    #echo 当前平台:$item_plat
    
    srcPath="${curIPFilePath}/${IPListFileName}_${item_type}_${item_plat}.ini"
    destPath="${ResultPath}/${item_type}/${item_plat}"
    mkdir $destPath -p
    destIPListFile="${ResultPath}/${item_type}/${item_plat}/${IPListFile}"
    echo destIPListFile:$destIPListFile
    
    #\cp $IPListFile  $destIPListFile
    \cp $srcPath $destIPListFile -f
   
  done

done

echo ----------------------------------------------------

