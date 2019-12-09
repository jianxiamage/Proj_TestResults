#!/bin/bash

#----------------------------------------------------------------------------------------

if [ $# -ne 4 ];then
 echo "usage: $0 TestType Platform TestCase Node_num" 
 exit 1
fi

#----------------------------------------------------------------------------------------
TestType="$1"
Platform="$2"
TestCase="$3"
Node_num="$4"
#----------------------------------------------------------------------------------------
resultsPath=$(cat result_path.txt)
PointsPath='Points_Files'
#----------------------------------------------------------------------------------------
#测试结果文件(筛选内容后)地址
destResultPath="${resultsPath}/${TestType}/${Platform}/$TestCase/$PointsPath/Points_${TestCase}_${Node_num}.txt"

#测试结果配置文件地址
destIniPath="${resultsPath}/${TestType}/${Platform}/$TestCase/$PointsPath/${TestCase}_${Node_num}.ini"


if [ ! -s $destResultPath ];
then
  echo Error! [$destResultPath] not existed!Please check it!
  exit 1
fi

if [ ! -s $destIniPath ];
then
  echo Error! [$destIniPath] not existed!Please check it!
  exit 1
fi

#读取测试结果跑分情况，并记录在相应的配置文件中

function get_compiler()
{

  key_name='compiler'
  #key_val=`cat  $destResultPath |awk 'NR==3'|awk '{print $5}'`
  key_val=`cat  $destResultPath | grep $key_name |awk '{print $2}'`
  python -c 'import mark_points_SpecJvm2008; mark_points_SpecJvm2008.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'")'

}


function get_compress()
{

  key_name='compress'
  key_val=`cat  $destResultPath | grep $key_name |awk '{print $2}'`
  python -c 'import mark_points_SpecJvm2008; mark_points_SpecJvm2008.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'")'

}

function get_crypto()
{

  key_name='crypto'
  key_val=`cat  $destResultPath | grep $key_name |awk '{print $2}'`
  python -c 'import mark_points_SpecJvm2008; mark_points_SpecJvm2008.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'")'

}


function get_derby()
{

  key_name='derby'
  key_val=`cat  $destResultPath | grep $key_name |awk '{print $2}'`
  python -c 'import mark_points_SpecJvm2008; mark_points_SpecJvm2008.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'")'

}

function get_mpegaudio()
{

  key_name='mpegaudio'
  key_val=`cat  $destResultPath | grep $key_name |awk '{print $2}'`
  python -c 'import mark_points_SpecJvm2008; mark_points_SpecJvm2008.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'")'

}

function get_scimark_large()
{

  key_name='scimark.large'
  key_val=`cat  $destResultPath | grep $key_name |awk '{print $2}'`
  python -c 'import mark_points_SpecJvm2008; mark_points_SpecJvm2008.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'")'

}

function get_scimark_small()
{

  key_name='scimark.small'
  key_val=`cat  $destResultPath | grep $key_name |awk '{print $2}'`
  python -c 'import mark_points_SpecJvm2008; mark_points_SpecJvm2008.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'")'

}


function get_serial()
{

  key_name='serial'
  key_val=`cat  $destResultPath | grep $key_name |awk '{print $2}'`
  python -c 'import mark_points_SpecJvm2008; mark_points_SpecJvm2008.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'")'

}

function get_startup()
{

  key_name='startup'
  key_val=`cat  $destResultPath | grep $key_name |awk '{print $2}'`
  python -c 'import mark_points_SpecJvm2008; mark_points_SpecJvm2008.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'")'

}

function get_sunflow()
{

  key_name='sunflow'
  key_val=`cat  $destResultPath | grep $key_name |awk '{print $2}'`
  python -c 'import mark_points_SpecJvm2008; mark_points_SpecJvm2008.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'")'

}


function get_xml()
{

  key_name='xml'
  key_val=`cat  $destResultPath | grep $key_name |awk '{print $2}'`
  python -c 'import mark_points_SpecJvm2008; mark_points_SpecJvm2008.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'")'

}

function get_Composite_result()
{

  search_str="Composite\ result"
  key_name='Composite-result'
  key_val=`cat  $destResultPath | grep "$search_str" |awk '{print $3}'`
  python -c 'import mark_points_SpecJvm2008; mark_points_SpecJvm2008.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'")'

}


get_compiler

get_compress

get_crypto

get_derby

get_mpegaudio

get_scimark_large

get_scimark_small

get_serial

get_startup

get_sunflow

get_xml

get_Composite_result

