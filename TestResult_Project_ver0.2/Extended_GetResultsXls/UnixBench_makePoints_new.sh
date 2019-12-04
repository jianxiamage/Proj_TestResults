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

#提前初始化测试结果文件,防止没有生成测试结果时,造成制作Excel失败的情况
#单线程


ls $TestCase_absdir  | grep "Unixbench_1thread" |grep "BASELINE"
if [ $? -eq 0 ];
then
  echo 测试用例:$TestCase 的单线程测试结果文件(BASELINE)内容为:
  echo --------------------------------------------------------------------------------
  cat ${TestCase_absdir}/Unixbench_1thread_BASELINE*.ini
  \cp ${TestCase_absdir}/Unixbench_1thread_BASELINE*.ini $destResultPath/${TestCase}_1_BASELINE_${Node_num}.ini -f

  #testcase_pointsFile_1thread="$curPointsIniDir/${TestCase}_1thread.ini"
  #\cp $testcase_pointsFile_1thread $destResultPath/${TestCase}_1thread_${Node_num}.ini -f
fi

ls $TestCase_absdir  | grep "Unixbench_1thread" |grep "RESULT"
if [ $? -eq 0 ];
then
  echo 测试用例:$TestCase 的单线程测试结果文件(RESULT)内容为:
  echo --------------------------------------------------------------------------------
  cat ${TestCase_absdir}/Unixbench_1thread_RESULT*.ini
  \cp ${TestCase_absdir}/Unixbench_1thread_RESULT*.ini $destResultPath/${TestCase}_1_RESULT_${Node_num}.ini -f
fi

ls $TestCase_absdir  | grep "Unixbench_1thread" |grep "INDEX"
if [ $? -eq 0 ];
then
  echo 测试用例:$TestCase 的单线程测试结果文件(INDEX)内容为:
  echo --------------------------------------------------------------------------------
  cat ${TestCase_absdir}/Unixbench_1thread_INDEX*.ini
  \cp ${TestCase_absdir}/Unixbench_1thread_INDEX*.ini $destResultPath/${TestCase}_1_INDEX_${Node_num}.ini -f
fi


ls $TestCase_absdir  | grep "Unixbench_2thread" |grep "BASELINE"
if [ $? -eq 0 ];
then
  echo 测试用例:$TestCase 的2线程测试结果文件(BASELINE)内容为:
  echo --------------------------------------------------------------------------------
  cat ${TestCase_absdir}/Unixbench_2thread_BASELINE*.ini
  \cp ${TestCase_absdir}/Unixbench_2thread_BASELINE*.ini $destResultPath/${TestCase}_2_BASELINE_${Node_num}.ini -f
fi

ls $TestCase_absdir  | grep "Unixbench_2thread" |grep "RESULT"
if [ $? -eq 0 ];
then
  echo 测试用例:$TestCase 的2线程测试结果文件(RESULT)内容为:
  echo --------------------------------------------------------------------------------
  cat ${TestCase_absdir}/Unixbench_2thread_RESULT*.ini
  \cp ${TestCase_absdir}/Unixbench_2thread_RESULT*.ini $destResultPath/${TestCase}_2_RESULT_${Node_num}.ini -f
fi

ls $TestCase_absdir  | grep "Unixbench_2thread" |grep "INDEX"
if [ $? -eq 0 ];
then
  echo 测试用例:$TestCase 的2线程测试结果文件(INDEX)内容为:
  echo --------------------------------------------------------------------------------
  cat ${TestCase_absdir}/Unixbench_2thread_INDEX*.ini
  \cp ${TestCase_absdir}/Unixbench_2thread_INDEX*.ini $destResultPath/${TestCase}_2_INDEX_${Node_num}.ini -f
fi

ls $TestCase_absdir  | grep "Unixbench_4thread" |grep "BASELINE"
if [ $? -eq 0 ];
then
  echo 测试用例:$TestCase 的4线程测试结果文件(BASELINE)内容为:
  echo --------------------------------------------------------------------------------
  cat ${TestCase_absdir}/Unixbench_4thread_BASELINE*.ini
  \cp ${TestCase_absdir}/Unixbench_4thread_BASELINE*.ini $destResultPath/${TestCase}_4_BASELINE_${Node_num}.ini -f
fi

ls $TestCase_absdir  | grep "Unixbench_4thread" |grep "RESULT"
if [ $? -eq 0 ];
then
  echo 测试用例:$TestCase 的4线程测试结果文件(RESULT)内容为:
  echo --------------------------------------------------------------------------------
  cat ${TestCase_absdir}/Unixbench_4thread_RESULT*.ini
  \cp ${TestCase_absdir}/Unixbench_4thread_RESULT*.ini $destResultPath/${TestCase}_4_RESULT_${Node_num}.ini -f
fi

ls $TestCase_absdir  | grep "Unixbench_4thread" |grep "INDEX"
if [ $? -eq 0 ];
then
  echo 测试用例:$TestCase 的4线程测试结果文件(INDEX)内容为:
  echo --------------------------------------------------------------------------------
  cat ${TestCase_absdir}/Unixbench_4thread_INDEX*.ini
  \cp ${TestCase_absdir}/Unixbench_4thread_INDEX*.ini $destResultPath/${TestCase}_4_INDEX_${Node_num}.ini -f
fi

ls $TestCase_absdir  | grep "Unixbench_8thread" |grep "BASELINE"
if [ $? -eq 0 ];
then
  echo 测试用例:$TestCase 的8线程测试结果文件(BASELINE)内容为:
  echo --------------------------------------------------------------------------------
  cat ${TestCase_absdir}/Unixbench_8thread_BASELINE*.ini
  \cp ${TestCase_absdir}/Unixbench_8thread_BASELINE*.ini $destResultPath/${TestCase}_8_BASELINE_${Node_num}.ini -f
fi

ls $TestCase_absdir  | grep "Unixbench_8thread" |grep "RESULT"
if [ $? -eq 0 ];
then
  echo 测试用例:$TestCase 的8线程测试结果文件(RESULT)内容为:
  echo --------------------------------------------------------------------------------
  cat ${TestCase_absdir}/Unixbench_8thread_RESULT*.ini
  \cp ${TestCase_absdir}/Unixbench_8thread_RESULT*.ini $destResultPath/${TestCase}_8_RESULT_${Node_num}.ini -f
fi

ls $TestCase_absdir  | grep "Unixbench_8thread" |grep "INDEX"
if [ $? -eq 0 ];
then
  echo 测试用例:$TestCase 的8线程测试结果文件(INDEX)内容为:
  echo --------------------------------------------------------------------------------
  cat ${TestCase_absdir}/Unixbench_8thread_INDEX*.ini
  \cp ${TestCase_absdir}/Unixbench_8thread_INDEX*.ini $destResultPath/${TestCase}_8_INDEX_${Node_num}.ini -f
fi

ls $TestCase_absdir  | grep "Unixbench_16thread" |grep "BASELINE"
if [ $? -eq 0 ];
then
  echo 测试用例:$TestCase 的16线程测试结果文件(BASELINE)内容为:
  echo --------------------------------------------------------------------------------
  cat ${TestCase_absdir}/Unixbench_16thread_BASELINE*.ini
  \cp ${TestCase_absdir}/Unixbench_16thread_BASELINE*.ini $destResultPath/${TestCase}_16_BASELINE_${Node_num}.ini -f
fi

ls $TestCase_absdir  | grep "Unixbench_16thread" |grep "RESULT"
if [ $? -eq 0 ];
then
  echo 测试用例:$TestCase 的16线程测试结果文件(RESULT)内容为:
  echo --------------------------------------------------------------------------------
  cat ${TestCase_absdir}/Unixbench_16thread_RESULT*.ini
  \cp ${TestCase_absdir}/Unixbench_16thread_RESULT*.ini $destResultPath/${TestCase}_16_RESULT_${Node_num}.ini -f
fi

ls $TestCase_absdir  | grep "Unixbench_16thread" |grep "INDEX"
if [ $? -eq 0 ];
then
  echo 测试用例:$TestCase 的16线程测试结果文件(INDEX)内容为:
  echo --------------------------------------------------------------------------------
  cat ${TestCase_absdir}/Unixbench_16thread_INDEX*.ini
  \cp ${TestCase_absdir}/Unixbench_16thread_INDEX*.ini $destResultPath/${TestCase}_16_INDEX_${Node_num}.ini -f
fi

