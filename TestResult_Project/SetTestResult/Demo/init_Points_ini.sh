#!/bin/bash

#尚未完成，可能已经不需要....
srcGroupFile='.ini'

ResultPath='/data'
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
    destPointsFile="${ResultPath}/${item_type}/"
    echo destPointsFile:$destPointsFile
 
    srcGroupFile="TestcaseGroup_${item_type}.ini"
    echo the srcGroupFile is:$srcGroupFile
    \cp $srcGroupFile $destPointsFile -f
    let i++
    

done

echo ----------------------------------------------------

