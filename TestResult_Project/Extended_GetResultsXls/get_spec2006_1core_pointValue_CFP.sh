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
resultsPath=$(cat data_path.txt)
PointsPath='Points_Files'
testMode='CFP'
#----------------------------------------------------------------------------------------
#测试结果文件(筛选内容后)地址
destResultPath="${resultsPath}/${TestType}/${Platform}/$TestCase/$PointsPath/Points_${TestCase}_${testMode}_${Node_num}.txt"

#测试结果配置文件地址
destIniPath="${resultsPath}/${TestType}/${Platform}/$TestCase/$PointsPath/${TestCase}_${testMode}_${Node_num}.ini"


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

function get_410_bwaves()
{

  key_name='410.bwaves'
  #key_val_str=`cat  $destResultPath | grep $key_name |awk '{print $4}'`
  #key_val=${key_val_str%%\**}
  key_val=`cat  $destResultPath | grep $key_name |awk '{print $4}'`
  python -c 'import mark_points_spec2006_1core; mark_points_spec2006_1core.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'","'$testMode'")'

}

function get_416_gamess()
{

  key_name='416.gamess'
  key_val=`cat  $destResultPath | grep $key_name |awk '{print $4}'`
  python -c 'import mark_points_spec2006_1core; mark_points_spec2006_1core.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'","'$testMode'")'

}

function get_433_milc()
{

  key_name='433.milc'
  key_val=`cat  $destResultPath | grep $key_name |awk '{print $4}'`
  python -c 'import mark_points_spec2006_1core; mark_points_spec2006_1core.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'","'$testMode'")'

}


function get_434_zeusmp()
{

  key_name='434.zeusmp'
  key_val=`cat  $destResultPath | grep $key_name |awk '{print $4}'`
  python -c 'import mark_points_spec2006_1core; mark_points_spec2006_1core.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'","'$testMode'")'

}


function get_435_gromacs()
{

  key_name='435.gromacs'
  key_val=`cat  $destResultPath | grep $key_name |awk '{print $4}'`
  python -c 'import mark_points_spec2006_1core; mark_points_spec2006_1core.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'","'$testMode'")'

}


function get_436_cactusADM()
{ 
  
  key_name='436.cactusADM'
  key_val=`cat  $destResultPath | grep $key_name |awk '{print $4}'`
  python -c 'import mark_points_spec2006_1core; mark_points_spec2006_1core.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'","'$testMode'")'

}


function get_437_leslie3d()
{

  key_name='437.leslie3d'
  key_val=`cat  $destResultPath | grep $key_name |awk '{print $4}'`
  python -c 'import mark_points_spec2006_1core; mark_points_spec2006_1core.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'","'$testMode'")'

}


function get_444_namd()
{

  key_name='444.namd'
  key_val=`cat  $destResultPath | grep $key_name |awk '{print $4}'`
  python -c 'import mark_points_spec2006_1core; mark_points_spec2006_1core.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'","'$testMode'")'

}


function get_447_dealII()
{

  key_name='447.dealII'
  key_val=`cat  $destResultPath | grep $key_name |awk '{print $4}'`
  python -c 'import mark_points_spec2006_1core; mark_points_spec2006_1core.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'","'$testMode'")'

}


function get_450_soplex()
{

  key_name='450.soplex'
  key_val=`cat  $destResultPath | grep $key_name |awk '{print $4}'`
  python -c 'import mark_points_spec2006_1core; mark_points_spec2006_1core.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'","'$testMode'")'

}



function get_453_povray()
{

  key_name='453.povray'
  key_val=`cat  $destResultPath | grep $key_name |awk '{print $4}'`
  python -c 'import mark_points_spec2006_1core; mark_points_spec2006_1core.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'","'$testMode'")'

}


function get_454_calculix()
{

  key_name='454.calculix'
  key_val=`cat  $destResultPath | grep $key_name |awk '{print $4}'`
  python -c 'import mark_points_spec2006_1core; mark_points_spec2006_1core.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'","'$testMode'")'

}



function get_459_GemsFDTD()
{

  key_name='459.GemsFDTD'
  key_val=`cat  $destResultPath | grep $key_name |awk '{print $4}'`
  python -c 'import mark_points_spec2006_1core; mark_points_spec2006_1core.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'","'$testMode'")'

}


function get_465_tonto()
{

  key_name='465.tonto'
  key_val=`cat  $destResultPath | grep $key_name |awk '{print $4}'`
  python -c 'import mark_points_spec2006_1core; mark_points_spec2006_1core.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'","'$testMode'")'

}


function get_470_lbm()
{

  key_name='470.lbm'
  key_val=`cat  $destResultPath | grep $key_name |awk '{print $4}'`
  python -c 'import mark_points_spec2006_1core; mark_points_spec2006_1core.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'","'$testMode'")'

}


function get_481_wrf()
{

  key_name='481.wrf'
  key_val=`cat  $destResultPath | grep $key_name |awk '{print $4}'`
  python -c 'import mark_points_spec2006_1core; mark_points_spec2006_1core.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'","'$testMode'")'

}


function get_482_sphinx3()
{

  key_name='482.sphinx3'
  key_val=`cat  $destResultPath | grep $key_name |awk '{print $4}'`
  python -c 'import mark_points_spec2006_1core; mark_points_spec2006_1core.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'","'$testMode'")'

}

function get_SPECfp_base2006()
{

  key_name='SPECfp_base2006'
  key_val=`cat  $destResultPath | grep $key_name |awk '{print $3}'`
  python -c 'import mark_points_spec2006_1core; mark_points_spec2006_1core.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'","'$testMode'")'

}


get_410_bwaves

get_416_gamess

get_433_milc

get_434_zeusmp

get_435_gromacs

get_436_cactusADM

get_437_leslie3d

get_444_namd

get_447_dealII

get_450_soplex

get_453_povray

get_454_calculix

get_459_GemsFDTD

get_465_tonto

get_470_lbm

get_481_wrf

get_482_sphinx3

get_SPECfp_base2006
