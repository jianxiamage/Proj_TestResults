#!/bin/bash

#----------------------------------------------------
#功能：制作各个平台各个测试类型的测试报告生成代码
#----------------------------------------------------

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


for item_type in ${TestType[@]}; do

  echo $item_type
  echo ----------------------------------------------------

  for item_plat in ${Platform[@]}; do

    echo 当前平台:$item_plat
    sh Create_Init_Env.sh ${item_type} ${item_plat}
   
  done

done

echo ----------------------------------------------------

