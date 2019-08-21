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
resultsPath='/data'
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

#读取iozone测试结果跑分情况，并记录在相应的配置文件中

function get_read()
{

  key_name='read'
  key_val=`cat  $destResultPath |awk 'NR==3'|awk '{print $5}'`
  python -c 'import mark_points_iozone; mark_points_iozone.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'")'

}

function get_Re_reader()
{

  key_name='Re-reader'
  key_val=`cat  $destResultPath |awk 'NR==3'|awk '{print $6}'`
  python -c 'import mark_points_iozone; mark_points_iozone.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'")'

}

function get_Random_Read()
{

  key_name='Random-Read'
  key_val=`cat  $destResultPath |awk 'NR==3'|awk '{print $7}'`
  python -c 'import mark_points_iozone; mark_points_iozone.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'")'

}

function get_write()
{

  key_name='write'
  key_val=`cat  $destResultPath |awk 'NR==3'|awk '{print $3}'`
  python -c 'import mark_points_iozone; mark_points_iozone.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'")'

}

function get_Re_writer()
{

  key_name='Re-writer'
  key_val=`cat  $destResultPath |awk 'NR==3'|awk '{print $4}'`
  python -c 'import mark_points_iozone; mark_points_iozone.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'")'

}

function get_Random_Write()
{

  key_name='Random-Write'
  key_val=`cat  $destResultPath |awk 'NR==3'|awk '{print $8}'`
  python -c 'import mark_points_iozone; mark_points_iozone.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'")'


}

get_read

get_Re_reader

get_Random_Read

get_write

get_Re_writer

get_Random_Write

