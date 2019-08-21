#!/bin/bash

#----------------------------------------------------------------------------------------

if [ $# -ne 3 ];then
 echo "usage: $0 TestType Platform TestCase" 
 exit 1
fi

#----------------------------------------------------------------------------------------
TestType="$1"
Platform="$2"
TestCase="$3"
#----------------------------------------------------------------------------------------
resultsPath='/data'
PointsPath='Points_Files'
Node_count=0
#----------------------------------------------------------------------------------------
#测试结果文件(筛选内容后)地址
destResultPath="${resultsPath}/${TestType}/${Platform}/$TestCase/$PointsPath"

#测试结果配置文件地址
#destIniPath="${resultsPath}/${TestType}/${Platform}/$TestCase/$PointsPath/${TestCase}_${Node_count}.ini"


if [ ! -s $destResultPath ];
then
  echo Error! [$destResultPath] not existed!Please check it!
  exit 1
fi

#if [ ! -s $destIniPath ];
#then
#  echo Error! [$destIniPath] not existed!Please check it!
#  exit 1
#fi

echo -------------------------------------------------------------

#读取测试结果情况，并将本组测试结果跑分情况写入配置文件

#spec2006单核浮点型测试结果
echo "**************************************************************"
echo spec2006-ncore CFP result getting...
echo "**************************************************************"

sh get_score_2config_spec2006_ncore_CFP.sh $TestType $Platform $TestCase  || { echo "Error!Get spec2006-ncore CFP result failed!";exit 1; }

#spec2006单核整型测试结果
echo "**************************************************************"
echo spec2006-ncore CINT result getting...
echo "**************************************************************"

sh get_score_2config_spec2006_ncore_CINT.sh $TestType $Platform $TestCase  || { echo "Error!Get spec2006-ncore CINT result failed!";exit 1; }

echo -------------------------------------------------------------

