#!/bin/bash
set -e

#----------------------------------------------------------------------------------------
TestType="OS"
Platform="7A"
#----------------------------------------------------------------------------------------
ResultPath='/data'
ReportFile="report.html"
#----------------------------------------------------------------------------------------
#首先,初始化测试结果ini文件的路径文件:testResultIni_path.txt
#本文件的目录例如:
#TestReport_OS_7A/testcase/testResultIni_path.txt
Proj_Name='TestReport'

sh init_MakeIniPath.sh $TestType $Platform $Proj_Name || { echo "Error!Failed to init the ini file."; exit 1; }

cur_path=$(cd `dirname $0`; pwd)
#project_name="${project_path##*/}"
echo "The current path is:"
echo $cur_path

pro_dir="${Proj_Name}_${TestType}_${Platform}"

#pushd $cur_path

cd $pro_dir

python result.py || echo "Error!get the test report failed!";

#popd

destPath="${ResultPath}/${TestType}/${Platform}"
mkdir $destPath -p
destResultFile="${ResultPath}/${TestType}/${Platform}/${ReportFile}"
echo destResultFile:$destResultFile

\cp $ReportFile $destResultFile -f || { echo "Error!Failed to copy the test report."; exit 1;}

echo ----------------------------------------------
echo "Please check the test report:$ReportFile:"
echo "[$destResultFile]"
echo ----------------------------------------------

