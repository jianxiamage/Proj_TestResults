#!/bin/bash

#########################################
#脚本功能:
#生成指定测试类型和平台的测试报告
#########################################

#--------------------------------------
#输入参数个数判断
#--------------------------------------
if [ $# -ne 2 ];then
 echo "usage: $0 TestType Platform" 
 exit 1
fi

#----------------------------------------------------------------------------------------
TestType="$1"
Platform="$2"
#----------------------------------------------------------------------------------------

#----------------------------------------------------------------------------------------
ResultPath='/data'
ReportFile="report.html"
ReportFile_Simple="report_simple.html"
#----------------------------------------------------------------------------------------


#----------------------------------------------------------------------------------------
#首先,初始化测试结果ini文件的路径文件:testResultIni_path.txt
#本文件的目录例如:
#TestReport_OS_7A/testcase/testResultIni_path.txt
Proj_Name='TestReport'
#----------------------------------------------------------------------------------------

sh init_MakeIniPath.sh $TestType $Platform $Proj_Name || { echo "Error!Failed to init the ini file."; exit 1; }

cur_path=$(cd `dirname $0`; pwd)
#project_name="${project_path##*/}"
echo "The current path is:"
echo $cur_path

pro_dir="${Proj_Name}_${TestType}_${Platform}"

#pushd $cur_path

cd $pro_dir

#---------------------------------------------------------------------------------
#开始创建测试报告
#---------------------------------------------------------------------------------
#python result.py || { echo "Error!get the test report failed!"; exit 1; }
sh create_report_env.sh || { echo "Error!get the test report failed!"; exit 1; }

#popd

destPath="${ResultPath}/${TestType}/${Platform}"
mkdir $destPath -p
destResultFile="${ResultPath}/${TestType}/${Platform}/${ReportFile}"
destResultFile_Simple="${ResultPath}/${TestType}/${Platform}/${ReportFile_Simple}"
echo destResultFile:$destResultFile

#---------------------------------------------------------------------------------
#拷贝生成的测试报告文件到指定的目录下
#---------------------------------------------------------------------------------
#拷贝企业版功能版测试报告
\cp $ReportFile $destResultFile -f || { echo "Error!Failed to copy the perfect test report."; exit 1;}

#拷贝精简版功能版测试报告
\cp $ReportFile_Simple $destResultFile_Simple -f || { echo "Error!Failed to copy the simple test report."; exit 1;}

echo ----------------------------------------------
echo "Please check the test report:$ReportFile:"
echo "[$destResultFile]"
echo ----------------------------------------------

echo ----------------------------------------------
echo "Please check the simple test report:$ReportFile:"
echo "[$destResultFile_Simple]"
echo ----------------------------------------------
