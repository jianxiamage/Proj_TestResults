#!/bin/bash
set -e

#if [ $# -ne 3 ];then
# echo "usage: $0 TestType Platform TestCase" 
# exit 1
#fi

#----------------------------------------------------------------------------------------
TestType="KVM"
Platform="7A"
#----------------------------------------------------------------------------------------
ResultPath='/data'
ReportFile="report.html"
#----------------------------------------------------------------------------------------

cur_path=$(cd `dirname $0`; pwd)
#project_name="${project_path##*/}"
echo "The current path is:"
echo $cur_path

pro_dir="TestReport_${TestType}_${Platform}"

#pushd $cur_path

cd $pro_dir

python result.py || echo "Error!get the test report failed!";

#popd

destPath="${ResultPath}/${TestType}/${Platform}"
mkdir $destPath -p
destResultFile="${ResultPath}/${TestType}/${Platform}/${ReportFile}"
echo destResultFile:$destResultFile

\cp $ReportFile $destResultFile -f || echo "Error!Failed to copy the test report"

echo ----------------------------------------------
echo "Please check the test report:$ReportFile:"
echo "[$destResultFile]"
echo ----------------------------------------------

