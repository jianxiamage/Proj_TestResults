#!/bin/bash

#/data-std/测试类型/测试平台/TestResults.ini

#测试结果配置文件存储
#/data-std/测试类型/测试平台/TestResults_测试平台.ini
echo ----------------------------------------------------
sh init_TestResultsFile_para.sh OS
sh init_TestResultsFile_para.sh Kernel
sh init_TestResultsFile_para.sh KVM
echo ----------------------------------------------------

