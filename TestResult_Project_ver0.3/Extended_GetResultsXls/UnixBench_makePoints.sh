#!/bin/bash

if [ $# -ne 5 ];then
 #echo "usage: $0 TestType Platform TestCase TestCase_absdir TestCase_absfile Node_num" 
 echo "usage: $0 TestType Platform TestCase TestCase_absdir Node_num" 
 exit 1
fi
#----------------------------------------------------------------------------------------
TestType="$1"
Platform="$2"
TestCase="$3"
TestCase_absdir="$4"  #输入参数为绝对路径的原因是:含有不确定的包含ip的目录，直接获取比较困难,需再确认
Node_num="$5"
#----------------------------------------------------------------------------------------
resultsPath=$(cat result_path.txt)
PointsPath='Points_Files'
curPointsIniDir='ini_Points'
#----------------------------------------------------------------------------------------

echo ================TestCase_absdir:=================
echo $TestCase_absdir
echo --------------------------------------------------------------------------------
testcase_file=`ls $TestCase_absdir`
echo $testcase_file

detailDir="Detail"
destResultPath="${resultsPath}/${TestType}/${Platform}/${detailDir}/${TestCase}/${PointsPath}"
mkdir $destResultPath -p

ls $TestCase_absdir  | grep "Unixbench_1_"
if [ $? -eq 0 ];
then
  echo 测试用例:$TestCase 的单线程测试结果文件内容为:
  echo --------------------------------------------------------------------------------
  cat ${TestCase_absdir}/Unixbench_1_*.ini
  \cp ${TestCase_absdir}/Unixbench_1_*.ini $destResultPath/${TestCase}_1thread_${Node_num}.ini -f

  #testcase_pointsFile_1thread="$curPointsIniDir/${TestCase}_1thread.ini"
  #\cp $testcase_pointsFile_1thread $destResultPath/${TestCase}_1thread_${Node_num}.ini -f
fi

ls $TestCase_absdir | grep "Unixbench_2_"
if [ $? -eq 0 ];
then
  echo 测试用例:$TestCase 的2线程测试结果文件内容为:
  echo --------------------------------------------------------------------------------
  cat ${TestCase_absdir}/Unixbench_2_*.ini
  \cp ${TestCase_absdir}/Unixbench_2_*.ini $destResultPath/${TestCase}_2thread_${Node_num}.ini -f

  #testcase_pointsFile_2thread="$curPointsIniDir/${TestCase}_2thread.ini"
  #\cp $testcase_pointsFile_2thread $destResultPath/${TestCase}_2thread_${Node_num}.ini -f
fi

ls $TestCase_absdir | grep "Unixbench_4_"
if [ $? -eq 0 ];
then
  echo 测试用例:$TestCase 的4线程测试结果文件内容为:
  echo --------------------------------------------------------------------------------
  cat ${TestCase_absdir}/Unixbench_4_*.ini
  \cp ${TestCase_absdir}/Unixbench_4_*.ini $destResultPath/${TestCase}_4thread_${Node_num}.ini -f

  #testcase_pointsFile_4thread="$curPointsIniDir/${TestCase}_4thread.ini"
  #\cp $testcase_pointsFile_4thread $destResultPath/${TestCase}_4thread_${Node_num}.ini -f
fi

ls $TestCase_absdir | grep "Unixbench_8_"
if [ $? -eq 0 ];
then
  echo 测试用例:$TestCase 的8线程测试结果文件内容为:
  echo --------------------------------------------------------------------------------
  cat ${TestCase_absdir}/Unixbench_8_*.ini
  \cp ${TestCase_absdir}/Unixbench_8_*.ini $destResultPath/${TestCase}_8thread_${Node_num}.ini -f

  #testcase_pointsFile_8thread="$curPointsIniDir/${TestCase}_8thread.ini"
  #\cp $testcase_pointsFile_8thread $destResultPath/${TestCase}_8thread_${Node_num}.ini -f
fi


ls $TestCase_absdir | grep "Unixbench_16_"
if [ $? -eq 0 ];
then
  echo 测试用例:$TestCase 的16线程测试结果文件内容为:
  echo --------------------------------------------------------------------------------
  cat ${TestCase_absdir}/Unixbench_16_*.ini
  \cp ${TestCase_absdir}/Unixbench_16_*.ini $destResultPath/${TestCase}_16thread_${Node_num}.ini -f

  #testcase_pointsFile_16thread="$curPointsIniDir/${TestCase}_16thread.ini"
  #\cp $testcase_pointsFile_16thread $destResultPath/${TestCase}_16thread_${Node_num}.ini -f
fi


