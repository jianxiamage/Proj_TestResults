#!/bin/bash

if [ $# -ne 2 ];then
 echo "usage: $0 TestType Platform" 
 exit 1
fi
#------------------------------------------------------
TestType=$1
Platform=$2
#------------------------------------------------------
#标准模板用以添加新的测试报告项目
Std_TestReprotDir="TestReport_Dir" 

#根据测试类型及测试平台的不同生成的新的测试报告项目目录
TestReportDir="TestReport_${TestType}_${Platform}" 
#------------------------------------------------------

#------------------------------------------------------
StdTestFilePath=MakeTestFile    #存储测试用例文件的目录

#定义测试用例文件名称
StdCaseFile=${StdTestFilePath}/Std_CaseList_${TestType}.txt
#------------------------------------------------------

start_time=`date +%s` #定义脚本运行的开始时间

echo "Begin to create Test Report Dir.TestType:[$TestType],TestPlat:[$Platform]"

#mkdir $TestReportDir -p
#制作测试报告代码模板
\cp -draf ${Std_TestReprotDir} ${TestReportDir}

#向新制作的测试报告项目中添加所需文件
#添加测试用例文件（主要功能是确立测试用例以及顺序）
\cp ${StdTestFilePath}/Std_CaseList_${TestType}.txt ${TestReportDir}/Std_CaseList.txt -f

stop_time=`date +%s`  #定义脚本运行的结束时间

echo "Create Test Report Dir finished.TestType:[$TestType],TestPlat:[$Platform]"
echo "**********************************************"
echo "Exec Time:`expr $stop_time - $start_time`s"
echo "**********************************************"
