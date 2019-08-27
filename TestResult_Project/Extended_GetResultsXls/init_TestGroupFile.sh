#!/bin/bash


srcGroupFile='TestcaseGroup.ini'

ResultPath='/data'
#GroupIniFile=$srcGroupFile
echo copy the [$srcGroupFile] to dest Dir

destPath=''

#rm -rf /data

mkdir $ResultPath -p

TestType=("OS" "Kernel" "KVM")
i=1
for item_type in ${TestType[@]}; do

    echo ----------------------------------------------------
    echo 这是第$i个ini文件
    #echo 当前平台:$item_plat
    
    destPath="${ResultPath}/${item_type}"
    mkdir $destPath -p
    destGroupFile="${ResultPath}/${item_type}/"
    echo destGroupFile:$destGroupFile
 
    srcGroupFile="TestcaseGroup_${item_type}.ini"
    echo the srcGroupFile is:$srcGroupFile
    \cp $srcGroupFile $destGroupFile -f
    let i++
    

done

echo ----------------------------------------------------

