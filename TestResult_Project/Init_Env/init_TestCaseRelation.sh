#!/bin/bash


srcCaseFile='TestCaseRelation.file'

ResultPath='/data'
#GroupIniFile=$srcCaseFile
echo copy the [$srcCaseFile] to dest Dir

destPath=''

#rm -rf /data

mkdir $ResultPath -p

TestType=("OS" "Kernel" "KVM")
i=1
for item_type in ${TestType[@]}; do

    echo "----------------------------------------------------"
    echo 这是第$i个测试用例名称对应文件.
    #echo 当前平台:$item_plat
    
    destPath="${ResultPath}/${item_type}"
    mkdir $destPath -p
    destCaseFile="${ResultPath}/${item_type}/${srcCaseFile}"
    echo destCaseFile:$destCaseFile
 
    #srcCaseFile="TestCaseRelation_${item_type}.file"
    echo the srcCaseFile is:$srcCaseFile
    \cp $srcCaseFile $destCaseFile -f
    let i++

done

echo "----------------------------------------------------"
