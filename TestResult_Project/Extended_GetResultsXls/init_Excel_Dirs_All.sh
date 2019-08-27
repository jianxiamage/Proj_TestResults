#!/bin/bash

#测试结果Excel文件存储
#/data-std/测试类型/测试平台/merge_Excel
#/data-std/测试类型/测试平台/Results_Excel
echo "***************************************************"
echo "Begin to create Excel Dirs for TestType:OS"
sh init_Excel_Dirs_para.sh OS
echo "***************************************************"

echo "***************************************************"
echo "Begin to create Excel Dirs for TestType:Kernel"
sh init_Excel_Dirs_para.sh Kernel
echo "***************************************************"

echo "***************************************************"
echo "Begin to create Excel Dirs for TestType:KVM"
sh init_Excel_Dirs_para.sh KVM
echo "***************************************************"

