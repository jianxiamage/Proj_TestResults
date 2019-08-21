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
testMode='1thread'
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

function get_Dhrystone()
{
  #searchStr="Dhrystone 2 using register variables"
  searchStr="Dhrystone\ 2\ using\ register\ variables"
  key_name_1='BASELINE'
  #key_val=`cat  $destResultPath |awk 'NR==2'|awk '{print $4}'`
  #key_val_str=`cat  $destResultPath | grep $key_name |awk '{print $4}'`
  #key_val=${key_val_str%%\**}
  key_val_1=`cat  $destResultPath | grep "$searchStr" | awk '{print $6}'`
  #echo key_val_1: $key_val_1
  python -c 'import mark_points_UnixBench; mark_points_UnixBench.setPoint_Dhrystone("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name_1'","'$key_val_1'","'$testMode'")'

  key_name_2='RESULT'
  key_val_2=`cat  $destResultPath | grep "$searchStr" | awk '{print $7}'`
  #echo key_val_2: $key_val_2
  python -c 'import mark_points_UnixBench; mark_points_UnixBench.setPoint_Dhrystone("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name_2'","'$key_val_2'","'$testMode'")'

  key_name_3='INDEX'
  key_val_3=`cat  $destResultPath | grep "$searchStr" | awk '{print $8}'`
  #echo key_val_3: $key_val_3
  python -c 'import mark_points_UnixBench; mark_points_UnixBench.setPoint_Dhrystone("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name_3'","'$key_val_3'","'$testMode'")'


}


function get_Double_Precision()
{
  #searchStr="Double-Precision Whetstone"
  searchStr="Double-Precision\ Whetstone"

  key_name_1='BASELINE'
  key_val_1=`cat  $destResultPath | grep "$searchStr" | awk '{print $3}'`
  python -c 'import mark_points_UnixBench; mark_points_UnixBench.setPoint_Double_Precision("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name_1'","'$key_val_1'","'$testMode'")'

  key_name_2='RESULT'
  key_val_2=`cat  $destResultPath | grep "$searchStr" | awk '{print $4}'`
  python -c 'import mark_points_UnixBench; mark_points_UnixBench.setPoint_Double_Precision("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name_2'","'$key_val_2'","'$testMode'")'

  key_name_3='INDEX'
  key_val_3=`cat  $destResultPath | grep "$searchStr" | awk '{print $5}'`
  python -c 'import mark_points_UnixBench; mark_points_UnixBench.setPoint_Double_Precision("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name_3'","'$key_val_3'","'$testMode'")'


}


function get_Execl_Throughput()
{
  #searchStr="Execl Throughput"
  searchStr="Execl\ Throughput"

  key_name_1='BASELINE'
  key_val_1=`cat  $destResultPath | grep "$searchStr" | awk '{print $3}'`
  python -c 'import mark_points_UnixBench; mark_points_UnixBench.setPoint_Execl_Throughput("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name_1'","'$key_val_1'","'$testMode'")'

  key_name_2='RESULT'
  key_val_2=`cat  $destResultPath | grep "$searchStr" | awk '{print $4}'`
  python -c 'import mark_points_UnixBench; mark_points_UnixBench.setPoint_Execl_Throughput("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name_2'","'$key_val_2'","'$testMode'")'

  key_name_3='INDEX'
  key_val_3=`cat  $destResultPath | grep "$searchStr" | awk '{print $5}'`
  python -c 'import mark_points_UnixBench; mark_points_UnixBench.setPoint_Execl_Throughput("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name_3'","'$key_val_3'","'$testMode'")'


}


function get_File_Copy_1024()
{
  #searchStr="File Copy 1024 bufsize 2000 maxblocks"
  searchStr="File\ Copy\ 1024\ bufsize\ 2000\ maxblocks"

  key_name_1='BASELINE'
  key_val_1=`cat  $destResultPath | grep "$searchStr" | awk '{print $7}'`
  python -c 'import mark_points_UnixBench; mark_points_UnixBench.setPoint_File_Copy_1024("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name_1'","'$key_val_1'","'$testMode'")'

  key_name_2='RESULT'
  key_val_2=`cat  $destResultPath | grep "$searchStr" | awk '{print $8}'`
  python -c 'import mark_points_UnixBench; mark_points_UnixBench.setPoint_File_Copy_1024("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name_2'","'$key_val_2'","'$testMode'")'

  key_name_3='INDEX'
  key_val_3=`cat  $destResultPath | grep "$searchStr" | awk '{print $9}'`
  python -c 'import mark_points_UnixBench; mark_points_UnixBench.setPoint_File_Copy_1024("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name_3'","'$key_val_3'","'$testMode'")'

}


function get_File_Copy_256()
{
  #searchStr="File Copy 256 bufsize 500 maxblocks"
  searchStr="File\ Copy\ 256\ bufsize\ 500\ maxblocks"

  key_name_1='BASELINE'
  key_val_1=`cat  $destResultPath | grep "$searchStr" | awk '{print $7}'`
  python -c 'import mark_points_UnixBench; mark_points_UnixBench.setPoint_File_Copy_256("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name_1'","'$key_val_1'","'$testMode'")'

  key_name_2='RESULT'
  key_val_2=`cat  $destResultPath | grep "$searchStr" | awk '{print $8}'`
  python -c 'import mark_points_UnixBench; mark_points_UnixBench.setPoint_File_Copy_256("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name_2'","'$key_val_2'","'$testMode'")'

  key_name_3='INDEX'
  key_val_3=`cat  $destResultPath | grep "$searchStr" | awk '{print $9}'`
  python -c 'import mark_points_UnixBench; mark_points_UnixBench.setPoint_File_Copy_256("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name_3'","'$key_val_3'","'$testMode'")'

}


function get_File_Copy_4096()
{
  #searchStr="File Copy 4096 bufsize 8000 maxblocks"
  searchStr="File\ Copy\ 4096\ bufsize\ 8000\ maxblocks"

  key_name_1='BASELINE'
  key_val_1=`cat  $destResultPath | grep "$searchStr" | awk '{print $7}'`
  python -c 'import mark_points_UnixBench; mark_points_UnixBench.setPoint_File_Copy_4096("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name_1'","'$key_val_1'","'$testMode'")'

  key_name_2='RESULT'
  key_val_2=`cat  $destResultPath | grep "$searchStr" | awk '{print $8}'`
  python -c 'import mark_points_UnixBench; mark_points_UnixBench.setPoint_File_Copy_4096("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name_2'","'$key_val_2'","'$testMode'")'

  key_name_3='INDEX'
  key_val_3=`cat  $destResultPath | grep "$searchStr" | awk '{print $9}'`
  python -c 'import mark_points_UnixBench; mark_points_UnixBench.setPoint_File_Copy_4096("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name_3'","'$key_val_3'","'$testMode'")'

}



function get_Pipe_Throughput()
{
  #searchStr="Pipe Throughput"
  searchStr="Pipe\ Throughput"

  key_name_1='BASELINE'
  key_val_1=`cat  $destResultPath | grep "$searchStr" | awk '{print $3}'`
  python -c 'import mark_points_UnixBench; mark_points_UnixBench.setPoint_Pipe_Throughput("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name_1'","'$key_val_1'","'$testMode'")'

  key_name_2='RESULT'
  key_val_2=`cat  $destResultPath | grep "$searchStr" | awk '{print $4}'`
  python -c 'import mark_points_UnixBench; mark_points_UnixBench.setPoint_Pipe_Throughput("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name_2'","'$key_val_2'","'$testMode'")'

  key_name_3='INDEX'
  key_val_3=`cat  $destResultPath | grep "$searchStr" | awk '{print $5}'`
  python -c 'import mark_points_UnixBench; mark_points_UnixBench.setPoint_Pipe_Throughput("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name_3'","'$key_val_3'","'$testMode'")'

}

function get_Pipe_based_Context()
{
  #searchStr="Pipe-based Context Switching"
  searchStr="Pipe-based\ Context\ Switching"

  key_name_1='BASELINE'
  key_val_1=`cat  $destResultPath | grep "$searchStr" | awk '{print $4}'`
  python -c 'import mark_points_UnixBench; mark_points_UnixBench.setPoint_Pipe_based_Context("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name_1'","'$key_val_1'","'$testMode'")'

  key_name_2='RESULT'
  key_val_2=`cat  $destResultPath | grep "$searchStr" | awk '{print $5}'`
  python -c 'import mark_points_UnixBench; mark_points_UnixBench.setPoint_Pipe_based_Context("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name_2'","'$key_val_2'","'$testMode'")'

  key_name_3='INDEX'
  key_val_3=`cat  $destResultPath | grep "$searchStr" | awk '{print $6}'`
  python -c 'import mark_points_UnixBench; mark_points_UnixBench.setPoint_Pipe_based_Context("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name_3'","'$key_val_3'","'$testMode'")'

}


function get_Process_Creation()
{
  #searchStr="Process Creation"
  searchStr="Process\ Creation"

  key_name_1='BASELINE'
  key_val_1=`cat  $destResultPath | grep "$searchStr" | awk '{print $3}'`
  python -c 'import mark_points_UnixBench; mark_points_UnixBench.setPoint_Process_Creation("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name_1'","'$key_val_1'","'$testMode'")'

  key_name_2='RESULT'
  key_val_2=`cat  $destResultPath | grep "$searchStr" | awk '{print $4}'`
  python -c 'import mark_points_UnixBench; mark_points_UnixBench.setPoint_Process_Creation("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name_2'","'$key_val_2'","'$testMode'")'

  key_name_3='INDEX'
  key_val_3=`cat  $destResultPath | grep "$searchStr" | awk '{print $5}'`
  python -c 'import mark_points_UnixBench; mark_points_UnixBench.setPoint_Process_Creation("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name_3'","'$key_val_3'","'$testMode'")'

}


function get_sh_1concurrent()
{
  #searchStr="Shell Scripts (1 concurrent)"
  searchStr="Shell\ Scripts\ (1\ concurrent)"

  key_name_1='BASELINE'
  key_val_1=`cat  $destResultPath | grep "$searchStr" | awk '{print $5}'`
  python -c 'import mark_points_UnixBench; mark_points_UnixBench.setPoint_sh_1concurrent("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name_1'","'$key_val_1'","'$testMode'")'

  key_name_2='RESULT'
  key_val_2=`cat  $destResultPath | grep "$searchStr" | awk '{print $6}'`
  python -c 'import mark_points_UnixBench; mark_points_UnixBench.setPoint_sh_1concurrent("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name_2'","'$key_val_2'","'$testMode'")'

  key_name_3='INDEX'
  key_val_3=`cat  $destResultPath | grep "$searchStr" | awk '{print $7}'`
  python -c 'import mark_points_UnixBench; mark_points_UnixBench.setPoint_sh_1concurrent("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name_3'","'$key_val_3'","'$testMode'")'

}


function get_sh_8concurrent()
{
  #searchStr="Shell Scripts (8 concurrent)"
  searchStr="Shell\ Scripts\ (8\ concurrent)"

  key_name_1='BASELINE'
  key_val_1=`cat  $destResultPath | grep "$searchStr" | awk '{print $5}'`
  python -c 'import mark_points_UnixBench; mark_points_UnixBench.setPoint_sh_8concurrent("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name_1'","'$key_val_1'","'$testMode'")'

  key_name_2='RESULT'
  key_val_2=`cat  $destResultPath | grep "$searchStr" | awk '{print $6}'`
  python -c 'import mark_points_UnixBench; mark_points_UnixBench.setPoint_sh_8concurrent("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name_2'","'$key_val_2'","'$testMode'")'

  key_name_3='INDEX'
  key_val_3=`cat  $destResultPath | grep "$searchStr" | awk '{print $7}'`
  python -c 'import mark_points_UnixBench; mark_points_UnixBench.setPoint_sh_8concurrent("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name_3'","'$key_val_3'","'$testMode'")'

}

function get_Sys_Call_Overhead()
{
  #searchStr="System Call Overhead"
  searchStr="System\ Call\ Overhead"

  key_name_1='BASELINE'
  key_val_1=`cat  $destResultPath | grep "$searchStr" | awk '{print $4}'`
  python -c 'import mark_points_UnixBench; mark_points_UnixBench.setPoint_Sys_Call_Overhead("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name_1'","'$key_val_1'","'$testMode'")'

  key_name_2='RESULT'
  key_val_2=`cat  $destResultPath | grep "$searchStr" | awk '{print $5}'`
  python -c 'import mark_points_UnixBench; mark_points_UnixBench.setPoint_Sys_Call_Overhead("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name_2'","'$key_val_2'","'$testMode'")'

  key_name_3='INDEX'
  key_val_3=`cat  $destResultPath | grep "$searchStr" | awk '{print $6}'`
  python -c 'import mark_points_UnixBench; mark_points_UnixBench.setPoint_Sys_Call_Overhead("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name_3'","'$key_val_3'","'$testMode'")'

}


function get_System_Benchmarks()
{
  #searchStr="System Benchmarks Index Sthread"
  searchStr="System\ Benchmarks\ Index\ Score"

  key_name='Score'
  key_val=`cat  $destResultPath | grep "$searchStr" | awk '{print $5}'`
  python -c 'import mark_points_UnixBench; mark_points_UnixBench.setPoint_System_Benchmarks("'$TestType'","'$Platform'","'$TestCase'","'$Node_num'","'$key_name'","'$key_val'","'$testMode'")'


}


get_Dhrystone

get_Double_Precision

get_Execl_Throughput

get_File_Copy_1024

get_File_Copy_256

get_File_Copy_4096

get_Pipe_Throughput

get_Pipe_based_Context

get_Process_Creation

get_sh_1concurrent

get_sh_8concurrent

get_Sys_Call_Overhead

get_System_Benchmarks
