#!/bin/bash

#------------------------------------------------------------------------
#初始化测试环境
#1.放置所有测试节点ip分组详细信息
#2.放置所有测试用例分组配置文件
#3.放置所有测试用例存储文件
#------------------------------------------------------------------------


#------------------------------------------------------------------------
#1.放置所有测试节点ip分组详细信息
#文件名:ip_list.ini
#复制文件到:/IPList/测试类型/测试平台/ip_list.ini
#------------------------------------------------------------------------
sh init_IPListFile.sh


#------------------------------------------------------------------------
##2.放置所有测试用例分组配置文件
#文件名:TestcaseGroup_测试类型.ini
#例如:
#TestcaseGroup_OS.ini
#TestcaseGroup_Kernel.ini
#TestcaseGroup_KVM.ini
#复制文件到:/data/测试类型/_测试类型.ini
#------------------------------------------------------------------------
sh init_TestGroupFile.sh


#------------------------------------------------------------------------
#3.放置所有测试用例存储文件
#文件名:TestResults.ini
#复制文件到:/data/测试类型/测试平台/TestResults.ini
#------------------------------------------------------------------------
sh init_TestResultsFile_All.sh
