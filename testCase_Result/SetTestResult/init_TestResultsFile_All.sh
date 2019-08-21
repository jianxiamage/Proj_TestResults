#!/bin/bash

#/data/测试类型/测试平台/TestResults.ini


#rm -rf /data
#测试结果配置文件存储
#/data/测试类型/测试平台/TestResults_测试平台.ini
echo ----------------------------------------------------
sh init_TestResultsFile_para.sh OS
sh init_TestResultsFile_para.sh Kernel
sh init_TestResultsFile_para.sh KVM
echo ----------------------------------------------------

