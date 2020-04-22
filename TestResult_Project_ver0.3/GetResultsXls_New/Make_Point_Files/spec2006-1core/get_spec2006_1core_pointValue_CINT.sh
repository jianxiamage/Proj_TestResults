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
curPointsIniDir='ini_Points'
testcase_pointsFile=$curPointsIniDir/${TestCase}_${testMode}.ini
#----------------------------------------------------------------------------------------
#测试结果文件(筛选内容后)地址
detailDir="Detail"
destResultPath="${resultsPath}/${TestType}/${Platform}/${detailDir}/${TestCase}/${PointsPath}/Points_${TestCase}_${testMode}_${Node_num}.txt"
#----------------------------------------------------------------------------------------

#----------------------------------------------------------------------------------------
#测试结果配置文件地址
dest_Path="${resultsPath}/${TestType}/${Platform}/${detailDir}/${TestCase}/${PointsPath}"
destIniPath="${dest_Path}/${TestCase}_${testMode}_${Node_num}.ini"
#----------------------------------------------------------------------------------------

if [ ! -s $destResultPath ];
then
  echo "[$destResultPath] not existed!Begin to init!"
  mkdir $dest_Path -p
  testcase_pointsFile=$curPointsIniDir/${TestCase}.ini
  \cp $testcase_pointsFile $destIniPath -f
  exit 0
fi


#读取测试结果跑分情况，并记录在相应的配置文件中

function get_400_perlbench()
{

  key_name='400.perlbench'
  #key_val_str=`cat  $destResultPath | grep $key_name |awk '{print $4}'`
  #key_val=${key_val_str%%\**}
  key_val=`cat  $destResultPath | grep $key_name |awk '{print $4}'`
  python -c 'import mark_points_spec2006_1core; mark_points_spec2006_1core.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'","'$testMode'")'

}


function get_401_bzip2()
{

  key_name='401.bzip2'
  key_val=`cat  $destResultPath | grep $key_name |awk '{print $4}'`
  python -c 'import mark_points_spec2006_1core; mark_points_spec2006_1core.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'","'$testMode'")'

}

function get_403_gcc()
{

  key_name='403.gcc'
  key_val=`cat  $destResultPath | grep $key_name |awk '{print $4}'`
  python -c 'import mark_points_spec2006_1core; mark_points_spec2006_1core.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'","'$testMode'")'

}


function get_429_mcf()
{

  key_name='429.mcf'
  key_val=`cat  $destResultPath | grep $key_name |awk '{print $4}'`
  python -c 'import mark_points_spec2006_1core; mark_points_spec2006_1core.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'","'$testMode'")'

}


function get_445_gobmk()
{

  key_name='445.gobmk'
  key_val=`cat  $destResultPath | grep $key_name |awk '{print $4}'`
  python -c 'import mark_points_spec2006_1core; mark_points_spec2006_1core.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'","'$testMode'")'

}


function get_456_hmmer()
{

  key_name='456.hmmer'
  key_val=`cat  $destResultPath | grep $key_name |awk '{print $4}'`
  python -c 'import mark_points_spec2006_1core; mark_points_spec2006_1core.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'","'$testMode'")'

}


function get_458_sjeng()
{

  key_name='458.sjeng'
  key_val=`cat  $destResultPath | grep $key_name |awk '{print $4}'`
  python -c 'import mark_points_spec2006_1core; mark_points_spec2006_1core.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'","'$testMode'")'

}


function get_462_libquantum()
{

  key_name='462.libquantum'
  key_val=`cat  $destResultPath | grep $key_name |awk '{print $4}'`
  python -c 'import mark_points_spec2006_1core; mark_points_spec2006_1core.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'","'$testMode'")'

}


function get_464_h264ref()
{

  key_name='464.h264ref'
  key_val=`cat  $destResultPath | grep $key_name |awk '{print $4}'`
  python -c 'import mark_points_spec2006_1core; mark_points_spec2006_1core.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'","'$testMode'")'

}


function get_471_omnetpp()
{

  key_name='471.omnetpp'
  key_val=`cat  $destResultPath | grep $key_name |awk '{print $4}'`
  python -c 'import mark_points_spec2006_1core; mark_points_spec2006_1core.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'","'$testMode'")'

}


function get_473_astar()
{

  key_name='473.astar'
  key_val=`cat  $destResultPath | grep $key_name |awk '{print $4}'`
  python -c 'import mark_points_spec2006_1core; mark_points_spec2006_1core.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'","'$testMode'")'

}


function get_483_xalancbmk()
{

  key_name='483.xalancbmk'
  key_val=`cat  $destResultPath | grep $key_name |awk '{print $4}'`
  python -c 'import mark_points_spec2006_1core; mark_points_spec2006_1core.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'","'$testMode'")'

}


function get_SPECint_base2006()
{

  key_name='SPECint_base2006'
  key_val=`cat  $destResultPath | grep $key_name |awk '{print $NF}'`
  python -c 'import mark_points_spec2006_1core; mark_points_spec2006_1core.setPoint("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'","'$testMode'")'

}


get_400_perlbench

get_401_bzip2

get_403_gcc

get_429_mcf

get_445_gobmk

get_456_hmmer

get_458_sjeng

get_462_libquantum

get_464_h264ref

get_471_omnetpp

get_473_astar

get_483_xalancbmk

get_SPECint_base2006

