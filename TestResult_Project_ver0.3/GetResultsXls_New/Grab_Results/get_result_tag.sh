#!/bin/bash

#################################################
#功能：
#用于获取单个性能测试结果文件,并存储到指定目录下
#################################################

#--------------------------------------------
#变量初始化
#--------------------------------------------
ServerIP='auto_test.loongson.cn'
ServerUser='loongson-test'
ServerPass='loongson'
#--------------------------------------------
AutoTestDir="/AutoTest"
ServerTestDir='autotest_result'
#--------------------------------------------
resultsPath='/data'
PointsPath='Points_Files'
#--------------------------------------------

#--------------------------------------------
#判断输入参数个数
#--------------------------------------------
if [ $# -ne 3 ];then
   echo "usage: $0 TestType Platform TestCase" 
   exit 0
fi

#--------------------------------------------
TestType="$1"
Platform="$2"
TestCase="$3"
#--------------------------------------------

#--------------------------------------------
ipList_TestCase_File="ipList_${TestCase}.txt"
tmpipList_TestCase_File="${ipList_TestCase_File}.tmp"
#--------------------------------------------

testcaseDir="${TestType}/${Platform}"

rm -rf $testcaseDir/$TestCase
mkdir -p $testcaseDir/$TestCase
testcase_ip_path="$testcaseDir/$ipList_TestCase_File"
testcase_ip_path_tmp="$testcaseDir/$tmpipList_TestCase_File"

#每次执行程序，都把之前生成的ip列表文件删除,重新生成一次，方便ip改变后，及时更新
rm -rf $testcase_ip_path

function writeIPFile()
{
   if [ $# -ne 1 ];then
     echo "usage: writeIPFile opt_name"
     return
   fi

   retCode=0
   opt_name="$1"

   count_items=$(python -c 'import get_node_count; print get_node_count.getSectionCount("'$TestType'","'$Platform'","'$opt_name'")')
   echo count_items is:$count_items 
  
   for((i=1;i<=count_items;i++));
   do
     #IP_testcase=`python get_node_ip.py $opt_name $i`
     IP_testcase=$(python -c 'import get_node_ip; print get_node_ip.getResult("'$TestType'","'$Platform'","'$opt_name'","'$i'")')
     echo 第[$i]个ip:$IP_testcase
     echo $IP_testcase  >>  $testcase_ip_path
   done

}

#--------------------------------------------
check_result()
{

    if [ $# -ne 1 ];then
      echo "usage: check_result TestName"
      return 1
    fi

    TestName="$1"
    echo "--------------------------------------------------------"
    echo Begin to get the state of Test Case:[$TestName]
    echo "--------------------------------------------------------"
    i=0
    exec 3< $testcase_ip_path_tmp
    while read host <&3
    do
        echo "--------------------------------------------------------"
        let i++
        \cp -draf ${AutoTestDir}/$ServerTestDir/$TestName/$host-* ${testcaseDir}/${TestName} || { echo 'Error!'; }

        echo get [$host] state OK.

        getResult=$(python -c 'import get_test_result; print get_test_result.getResult("'$TestType'","'$Platform'","'$TestName'","'$i'")')
        echo [$TestType $Platform $TestName $i]:$getResult

        echo "-----------------------获取测试用例结果文件信息---------------------------"

        workdir=$(cd $(dirname $0); pwd)
        #workdir=../$DownLoad_Path

        pwd
        echo "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
        ls $workdir/$TestType/$Platform/$TestName
        echo "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

        hostDirCount=`ls $workdir/$TestType/$Platform/$TestName |grep $host- |wc -l`
        echo ============The number of directories currently containing IP:$host is:$hostDirCount
        #可能会出现服务器上有多个含有相同ip但时间不同的文件夹，
        #这是意外情况，实际上是不允许出现这种情况的
        #还需要排除的是测试尚未进行完的情况，这时正常情况
        if [ $hostDirCount -ne 0 -a $hostDirCount -ne 1 ];
        then
           echo "Error,more than 1 ip dir existed!Please check it!"
           echo "There must be only 1 ip dir."
           echo "-----------------------------------------"
           echo "Please check the ip dirs:"
           ls $workdir/$TestType/$Platform/$TestName |grep $host-
           echo "-----------------------------------------"
           exit 1
        fi

        testresult_dir=`ls $workdir/$TestType/$Platform/$TestName |grep $host-`
        echo testresult_dir:$testresult_dir
        testresult_absdir=$workdir/$TestType/$Platform/$TestName/$testresult_dir
        echo --------------------------------------------------------------------------------   
        echo 测试用例:$TestCase 的测试结果目录为:
        echo [$testresult_absdir]
        echo --------------------------------------------------------------------------------   
      
        #testcase_dir=`ls $testresult_absdir |grep $TestName` #因为服务器上这个目录规则不统一，无法根据名称进行筛选???
        testcase_dir=`ls $testresult_absdir`
        testcase_absdir=$testresult_absdir/$testcase_dir
        echo --------------------------------------------------------------------------------   
        echo 测试用例:$TestCase 的测试结果文件所在目录为:
        echo [$testcase_absdir]
        echo --------------------------------------------------------------------------------   
      
#        testcase_file=`ls $testcase_absdir | grep ^$TestName`
#        #echo 测试用例:$TestCase 的测试结果文件为:[$testcase_file]
#        echo $testcase_file
#        testcase_absfile=$testcase_absdir/$testcase_file
#        echo 测试用例:$TestCase 的测试结果文件为:[$testcase_absfile]
#        echo -------------------------------------------------------------------------------- 
        
        echo "*********************************************************"
        echo "当前编号:$i"
        echo "*********************************************************"
        #sh makePonitsFile.sh $TestType $Platform $TestCase $testcase_absdir $testcase_absfile $i || echo 出错了，请检查
        sh makePonitsFile.sh $TestType $Platform $TestCase $testcase_absdir $i || echo 出错了，请检查

    done < $testcase_ip_path_tmp

    return 0
}

#-----------------------------------------------------------------------------------
#删除目标目录下曾经获取的跑分文件(txt格式)
#如不删除，下次测试会认为已经获取了跑分文件，其实是上次的结果没有删除
detailDir="Detail"
destPath="${resultsPath}/${TestType}/${Platform}/${detailDir}/$TestCase/$PointsPath"
mkdir $destPath -p

rm -rf $destPath/*.txt
#-----------------------------------------------------------------------------------

rm -rf $testcase_ip_path

#writeIPFile stressapp 
writeIPFile $TestCase


#Delete the space lines and comment lines
sed '/^#.*\|^[[:space:]]*$/d' $testcase_ip_path> $testcase_ip_path_tmp


#check_result testcase 
check_result $TestCase

rm -rf $testcase_ip_path_tmp

echo "--------------------------------------------------------"
