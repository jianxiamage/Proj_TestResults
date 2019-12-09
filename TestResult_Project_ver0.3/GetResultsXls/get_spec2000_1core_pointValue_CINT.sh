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
testMode='CINT'
#----------------------------------------------------------------------------------------
#测试结果文件(筛选内容后)地址
detailDir="Detail"
destResultPath="${resultsPath}/${TestType}/${Platform}/${detailDir}/${TestCase}/${PointsPath}/Points_${TestCase}_${testMode}_${Node_num}.txt"

#测试结果配置文件地址
destIniPath="${resultsPath}/${TestType}/${Platform}/${detailDir}/${TestCase}/${PointsPath}/${TestCase}_${testMode}_${Node_num}.ini"


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

function get_164_gzip()
{

  key_name='164.gzip'
  #key_val=`cat  $destResultPath |awk 'NR==2'|awk '{print $4}'`
  key_val_str=`cat  $destResultPath | grep $key_name |awk '{print $4}'`
  key_val=${key_val_str%%\**}
  python -c 'import mark_points_spec2000_1core; mark_points_spec2000_1core.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'","'$testMode'")'

}

function get_175_vpr()
{

  key_name='175.vpr'
  key_val_str=`cat  $destResultPath | grep $key_name |awk '{print $4}'`
  key_val=${key_val_str%%\**}
  python -c 'import mark_points_spec2000_1core; mark_points_spec2000_1core.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'","'$testMode'")'

}

function get_176_gcc()
{

  key_name='176.gcc'
  key_val_str=`cat  $destResultPath | grep $key_name |awk '{print $4}'`
  key_val=${key_val_str%%\**}
  python -c 'import mark_points_spec2000_1core; mark_points_spec2000_1core.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'","'$testMode'")'

}

function get_181_mcf()
{

  key_name='181.mcf'
  key_val_str=`cat  $destResultPath | grep $key_name |awk '{print $4}'`
  key_val=${key_val_str%%\**}
  python -c 'import mark_points_spec2000_1core; mark_points_spec2000_1core.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'","'$testMode'")'

}

function get_186_crafty()
{

  key_name='186.crafty'
  key_val_str=`cat  $destResultPath | grep $key_name |awk '{print $4}'`
  key_val=${key_val_str%%\**}
  python -c 'import mark_points_spec2000_1core; mark_points_spec2000_1core.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'","'$testMode'")'

}

function get_197_parser()
{

  key_name='197.parser'
  key_val_str=`cat  $destResultPath | grep $key_name |awk '{print $4}'`
  key_val=${key_val_str%%\**}
  python -c 'import mark_points_spec2000_1core; mark_points_spec2000_1core.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'","'$testMode'")'


}

function get_252_eon()
{

  key_name='252.eon'
  key_val_str=`cat  $destResultPath | grep $key_name |awk '{print $4}'`
  key_val=${key_val_str%%\**}
  python -c 'import mark_points_spec2000_1core; mark_points_spec2000_1core.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'","'$testMode'")'


}


function get_253_perlbmk()
{

  key_name='253.perlbmk'
  key_val_str=`cat  $destResultPath | grep $key_name |awk '{print $4}'`
  key_val=${key_val_str%%\**}
  python -c 'import mark_points_spec2000_1core; mark_points_spec2000_1core.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'","'$testMode'")'

}


function get_254_gap()
{

  key_name='254.gap'
  key_val_str=`cat  $destResultPath | grep $key_name |awk '{print $4}'`
  key_val=${key_val_str%%\**}
  python -c 'import mark_points_spec2000_1core; mark_points_spec2000_1core.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'","'$testMode'")'

}


function get_255_vortex()
{

  key_name='255.vortex'
  key_val_str=`cat  $destResultPath | grep $key_name |awk '{print $4}'`
  key_val=${key_val_str%%\**}
  python -c 'import mark_points_spec2000_1core; mark_points_spec2000_1core.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'","'$testMode'")'

}

function get_256_bzip2()
{

  key_name='256.bzip2'
  key_val_str=`cat  $destResultPath | grep $key_name |awk '{print $4}'`
  key_val=${key_val_str%%\**}
  python -c 'import mark_points_spec2000_1core; mark_points_spec2000_1core.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'","'$testMode'")'

}


function get_300_twolf()
{

  key_name='300.twolf'
  key_val_str=`cat  $destResultPath | grep $key_name |awk '{print $4}'`
  key_val=${key_val_str%%\**}
  python -c 'import mark_points_spec2000_1core; mark_points_spec2000_1core.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'","'$testMode'")'

}


function get_SPECint_base2000()
{

  key_name='SPECint_base2000'
  key_val=`cat  $destResultPath | grep $key_name |awk '{print $2}'`
  python -c 'import mark_points_spec2000_1core; mark_points_spec2000_1core.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'","'$testMode'")'

}


get_164_gzip

get_175_vpr

get_176_gcc

get_181_mcf

get_186_crafty

get_197_parser

get_252_eon

get_253_perlbmk

get_254_gap

get_255_vortex

get_256_bzip2

get_300_twolf

get_SPECint_base2000

