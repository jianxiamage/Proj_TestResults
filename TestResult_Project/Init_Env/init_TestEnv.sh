#!/bin/bash

#------------------------------------------------------------------------
#初始化测试环境
#1.放置所有测试节点ip分组详细信息
#2.放置所有测试用例分组配置文件
#3.放置所有测试用例存储文件
#4.创建测试结果Excel文件的存储目录
#5.搭建python虚拟环境
#6.安装必要软件
#7.复制必要文件
#------------------------------------------------------------------------


#------------------------------------------------------------------------
#1.放置所有测试节点ip分组详细信息
#文件名:ip_list.ini
#复制文件到:/data/测试类型/测试平台/ip_list.ini
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


#------------------------------------------------------------------------
#4.创建测试结果Excel文件的存储目录(多个Excel合并目录以及最终结果目录)
#合并目录:/data/测试类型/测试平台/merge-Excel
#最终目录:/data/测试类型/测试平台/Results-Excel
#------------------------------------------------------------------------
sh init_Excel_Dirs_All.sh


#------------------------------------------------------------------------
#5.搭建python虚拟环境（避免对本机python环境造成破坏）
#------------------------------------------------------------------------
sh init_work_env_wrapper.sh

#------------------------------------------------------------------------
#6.安装必要软件
#------------------------------------------------------------------------
sh init_pkg_required.sh

#------------------------------------------------------------------------
#7.复制必要文件
#------------------------------------------------------------------------
sh init_required_files.sh


echo "-------------------------------------------"
echo "OK,Now the test environment is finished."
echo "-------------------------------------------"

