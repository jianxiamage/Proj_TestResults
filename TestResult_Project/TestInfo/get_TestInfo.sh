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
retCode=0
onLineFlag=0
#--------------------------------------------
resultsPath="/data"
detailDir="Detail"
TestInfoDir="TestInfo"
destPath="${resultsPath}/${TestType}/${Platform}/${detailDir}/${TestInfoDir}/$TestCase/"
rm -rf $destPath
mkdir $destPath -p
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
        let i++

        workdir=$(cd $(dirname $0); pwd)

        echo 第[$i]个ip:$host
        ping -c3 -i0.3 -W1 $host &>/dev/null
        if [ $? -ne 0 ] ;then
           echo "[${host}] can not be connected!"
           onLineFlag=1
           \cp $workdir/StdTestInfo.ini "$destPath/Node${i}_${host}.ini" -f
           continue
        fi

        sshpass -p $ServerPass scp -o StrictHostKeychecking=no -r \
        $ServerUser@$ServerIP:~/$ServerTestDir/$TestName/*_${host}.out ${testcaseDir}/${TestName}

        if [ $? -ne 0 ];then
           echo "Node:[${host}]:Get time file failed."
           \cp $workdir/StdTestInfo.ini "$destPath/Node${i}_${host}.ini" -f
           continue
        fi

        echo "-----------------------获取测试信息文件---------------------------"
        #echo "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
        #ls -1 $workdir/$TestType/$Platform/$TestName
        #echo "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

        hostFileCount=`ls $workdir/$TestType/$Platform/$TestName |grep _${host}.out |wc -l`
        #echo "===The number of files currently containing IP:$host is:$hostFileCount"
        if [ $hostFileCount -ne 1 ];
        then
           echo "Warning,The current count of test file is:$hostFileCount"
           echo "There must be only 1 test file,You should check it."
           echo "-----------------------------------------"
           ls $workdir/$TestType/$Platform/$TestName |grep _${host}.out
           \cp $workdir/StdTestInfo.ini "$destPath/Node${i}_${host}.ini" -f
           continue
        fi

        testInfo_file=`ls $workdir/$TestType/$Platform/$TestName |grep _${host}.out`
        echo testInfo_file:$testInfo_file
        testInfo_absFile=$workdir/$TestType/$Platform/$TestName/$testInfo_file
        testInfo_content=$(cat $testInfo_absFile)
        echo "[TestInfo]" > "$destPath/Node${i}_${host}.ini"
        echo "StartTime:$testInfo_content" >> "$destPath/Node${i}_${host}.ini"
        #echo --------------------------------------------------------------------------------   
        #echo 测试用例:$TestCase 的测试结果文件为:
        #echo [$testInfo_absFile]
        #echo --------------------------------------------------------------------------------   
        #\cp $workdir/$TestType/$Platform/$TestName/*_${host}.out "$destPath/Node${i}_${host}.txt" -f

    done < $testcase_ip_path_tmp

    return 0
}


rm -rf $testcase_ip_path

#writeIPFile stressapp 
writeIPFile $TestCase


#Delete the space lines and comment lines
sed '/^#.*\|^[[:space:]]*$/d' $testcase_ip_path > $testcase_ip_path_tmp


#check_result testcase 
check_result $TestCase

rm -rf $testcase_ip_path_tmp

echo "--------------------------------------------------------"
retCode=$onLineFlag
exit $retCode
