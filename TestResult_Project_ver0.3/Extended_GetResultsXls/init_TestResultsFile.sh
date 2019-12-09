#!/bin/bash

#/data/TestResults.ini

srcResultFile='TestResults.ini'
IPListFile='ip_list.ini'

ResultPath='/data'
ResultIniFile=$srcResultFile
echo srcFile:$ResultIniFile

destPath=''

#rm -rf /data

mkdir $ResultPath -p

TestType=("OS" "Kernel" "KVM")

Platform=("7A" "7A_Integrated" "7A_2way" "780" "2K")

for item_type in ${TestType[@]}; do

  #echo $item_type
  echo ----------------------------------------------------

  for item_plat in ${Platform[@]}; do

    #echo 当前平台:$item_plat
    
    destPath="${ResultPath}/${item_type}/${item_plat}"
    mkdir $destPath -p
    destResultFile="${ResultPath}/${item_type}/${item_plat}/${srcResultFile}"
    #destIPListFile="${ResultPath}/${item_type}/${item_plat}/${IPListFile}"
    echo destResultFile:$destResultFile
    #echo destIPListFile:$destIPListFile
 
    \cp $srcResultFile $destResultFile -f

  done

done

echo ----------------------------------------------------

