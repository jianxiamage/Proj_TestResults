#!/bin/bash

#--------------------------------------------
ServerIP='auto_test.loongson.cn'
ServerUser='loongson-test'
ServerPass='loongson'
#--------------------------------------------

ServerTestDir='autotest_result'
#--------------------------------------------
#items_count=3
#--------------------------------------------

if [ $# -ne 3 ];then
   echo "usage: $0 TestType Platform TestCase" 
   exit 0
fi

TestType="$1"
Platform="$2"
TestCase="$3"

#--------------------------------------------
ipList_TestCase_File="ipList_${TestCase}.txt"
tmpipList_TestCase_File="${ipList_TestCase_File}.tmp"
#--------------------------------------------

#testcaseDir="7A"
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
   #opt_num="$2"

   #count_items=`python get_node_count.py $opt_name`

   #count_items=`python -c "import get_node_count;get_node_count.getSectionCount($opt_name)"`
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


function getResultFile()
{

  if [ $# -ne 4 ];then
     echo "usage: $0 TestType Platform TestCase" 
     exit 1
  fi
  
  TestType="$1"
  Platform="$2"
  TestCase="$3"
  TestHost="$4"
  echo "获取测试结果跑分..."
  echo "当前路径:"
  pwd 
  count_hosts=`ls $TestType/$Platform/$TestHost-* |wc -l`
  if [ $count_hosts -ne 1 ];
  then
     echo 当前路径下存在相同机器的文件夹，不允许的操作!
     exit 1
  fi
 
  workdir=$(cd $(dirname $0); pwd)
 
  testresult_dir=`ls $workdir/$TestType/$Platform |grep $TestHost-`
  echo testresult_dir:$testresult_dir
  testresult_absdir=$workdir/$TestType/$Platform/$testresult_dir
  echo --------------------------------------------------------------------------------   
  echo 测试用例:$TestCase 的测试结果目录为:
  echo [$testresult_absdir]
  echo --------------------------------------------------------------------------------   

  testcase_dir=`ls $testresult_absdir |grep $TestCase`
  testcase_absdir=$testresult_absdir/$testcase_dir
  echo --------------------------------------------------------------------------------   
  echo 测试用例:$TestCase 的测试结果文件所在目录为
  echo [$testcase_absdir]
  echo --------------------------------------------------------------------------------   

  testcase_file=`ls $testcase_absdir`
  echo 测试用例:$TestCase 的测试结果文件为:
  echo [$testcase_file]
  testcase_absfile=$testcase_absdir/$testcase_file
  echo --------------------------------------------------------------------------------   
  echo 测试用例:$TestCase 的测试结果文件为:
  echo [$testcase_absfile]
  echo -------------------------------------------------------------------------------- 


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
        sshpass -p $ServerPass scp -o StrictHostKeychecking=no -r $ServerUser@$ServerIP:~/$ServerTestDir/$TestName/$host-* ${testcaseDir}/${TestName} || { echo 'Error!'; continue; }
        echo get [$host] state OK.

        getResult=$(python -c 'import get_test_result; print get_test_result.getResult("'$TestType'","'$Platform'","'$TestName'","'$i'")')
        echo [$TestType $Platform $TestName $i]:$getResult

        echo "-----------------------获取测试用例结果文件信息---------------------------"
        #getResultFile $TestType $Platform $TestCase $host

        workdir=$(cd $(dirname $0); pwd)
        pwd
        echo "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
        ls $workdir/$TestType/$Platform/$TestName
        echo "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

        hostDirCount=`ls $workdir/$TestType/$Platform/$TestName |grep $host- |wc -l`
        echo ============The number of directories currently containing IP:$host is:$hostDirCount
        if [ $hostDirCount -ne 1 ];
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
        
        #sh makePonitsFile.sh $TestType $Platform $TestCase $testcase_absdir $testcase_absfile $i || echo 出错了，请检查
        sh makePonitsFile.sh $TestType $Platform $TestCase $testcase_absdir $i || echo 出错了，请检查

    done < $testcase_ip_path_tmp

    return 0
}


rm -rf $testcase_ip_path

#writeIPFile stressapp 
writeIPFile $TestCase


#Delete the space lines and comment lines
sed '/^#.*\|^[[:space:]]*$/d' $testcase_ip_path> $testcase_ip_path_tmp


#check_result testcase 
check_result $TestCase

rm -rf $testcase_ip_path_tmp

echo "--------------------------------------------------------"
