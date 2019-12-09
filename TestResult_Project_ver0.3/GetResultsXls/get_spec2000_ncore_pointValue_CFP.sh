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
testMode='CFP'
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

function get_168_wupwise()
{

  key_name='168.wupwise'
  #key_val=`cat  $destResultPath |awk 'NR==2'|awk '{print $4}'`
  key_val_str=`cat  $destResultPath | grep $key_name |awk '{print $4}'`
  key_val=${key_val_str%%\**}
  python -c 'import mark_points_spec2000_ncore; mark_points_spec2000_ncore.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'","'$testMode'")'

}

function get_171_swim()
{

  key_name='171.swim'
  key_val_str=`cat  $destResultPath | grep $key_name |awk '{print $4}'`
  key_val=${key_val_str%%\**}
  python -c 'import mark_points_spec2000_ncore; mark_points_spec2000_ncore.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'","'$testMode'")'

}

function get_172_mgrid()
{

  key_name='172.mgrid'
  key_val_str=`cat  $destResultPath | grep $key_name |awk '{print $4}'`
  key_val=${key_val_str%%\**}
  python -c 'import mark_points_spec2000_ncore; mark_points_spec2000_ncore.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'","'$testMode'")'

}

function get_173_applu()
{

  key_name='173.applu'
  key_val_str=`cat  $destResultPath | grep $key_name |awk '{print $4}'`
  key_val=${key_val_str%%\**}
  python -c 'import mark_points_spec2000_ncore; mark_points_spec2000_ncore.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'","'$testMode'")'

}

function get_177_mesa()
{

  key_name='177.mesa'
  key_val_str=`cat  $destResultPath | grep $key_name |awk '{print $4}'`
  key_val=${key_val_str%%\**}
  python -c 'import mark_points_spec2000_ncore; mark_points_spec2000_ncore.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'","'$testMode'")'

}

function get_178_galgel()
{

  key_name='178.galgel'
  key_val_str=`cat  $destResultPath | grep $key_name |awk '{print $4}'`
  key_val=${key_val_str%%\**}
  python -c 'import mark_points_spec2000_ncore; mark_points_spec2000_ncore.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'","'$testMode'")'


}

function get_179_art()
{

  key_name='179.art'
  key_val_str=`cat  $destResultPath | grep $key_name |awk '{print $4}'`
  key_val=${key_val_str%%\**}
  python -c 'import mark_points_spec2000_ncore; mark_points_spec2000_ncore.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'","'$testMode'")'


}


function get_183_equake()
{

  key_name='183.equake'
  key_val_str=`cat  $destResultPath | grep $key_name |awk '{print $4}'`
  key_val=${key_val_str%%\**}
  python -c 'import mark_points_spec2000_ncore; mark_points_spec2000_ncore.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'","'$testMode'")'

}


function get_187_facerec()
{

  key_name='187.facerec'
  key_val_str=`cat  $destResultPath | grep $key_name |awk '{print $4}'`
  key_val=${key_val_str%%\**}
  python -c 'import mark_points_spec2000_ncore; mark_points_spec2000_ncore.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'","'$testMode'")'

}


function get_188_ammp()
{

  key_name='188.ammp'
  key_val_str=`cat  $destResultPath | grep $key_name |awk '{print $4}'`
  key_val=${key_val_str%%\**}
  python -c 'import mark_points_spec2000_ncore; mark_points_spec2000_ncore.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'","'$testMode'")'

}

function get_189_lucas()
{

  key_name='189.lucas'
  key_val_str=`cat  $destResultPath | grep $key_name |awk '{print $4}'`
  key_val=${key_val_str%%\**}
  python -c 'import mark_points_spec2000_ncore; mark_points_spec2000_ncore.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'","'$testMode'")'

}


function get_191_fma3d()
{

  key_name='191.fma3d'
  key_val_str=`cat  $destResultPath | grep $key_name |awk '{print $4}'`
  key_val=${key_val_str%%\**}
  python -c 'import mark_points_spec2000_ncore; mark_points_spec2000_ncore.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'","'$testMode'")'

}

function get_200_sixtrack()
{

  key_name='200.sixtrack'
  key_val_str=`cat  $destResultPath | grep $key_name |awk '{print $4}'`
  key_val=${key_val_str%%\**}
  python -c 'import mark_points_spec2000_ncore; mark_points_spec2000_ncore.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'","'$testMode'")'

}


function get_301_apsi()
{

  key_name='301.apsi'
  key_val_str=`cat  $destResultPath | grep $key_name |awk '{print $4}'`
  key_val=${key_val_str%%\**}
  python -c 'import mark_points_spec2000_ncore; mark_points_spec2000_ncore.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'","'$testMode'")'

}


function get_SPECfp_rate_base2000()
{

  key_name='SPECfp_rate_base2000'
  key_val=`cat  $destResultPath | grep $key_name |awk '{print $2}'`
  #key_val=${key_val_str%%\**}
  python -c 'import mark_points_spec2000_ncore; mark_points_spec2000_ncore.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'","'$testMode'")'

}


get_168_wupwise

get_171_swim

get_172_mgrid

get_173_applu

get_177_mesa

get_178_galgel

get_179_art

get_183_equake

get_187_facerec

get_188_ammp

get_189_lucas

get_191_fma3d

get_200_sixtrack

get_301_apsi

get_SPECfp_rate_base2000
