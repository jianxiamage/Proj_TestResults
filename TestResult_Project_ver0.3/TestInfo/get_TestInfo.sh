#!/bin/bash

#####################################################################
#脚本功能:
#用于获取指定测试类型和平台的每个测试用例对应的三个并发节点的测试信息
#当前测试信息，主要是测试用例开始测试时间
#####################################################################

#--------------------------------------------
ServerIP='auto_test.loongson.cn'
ServerUser='loongson-test'
ServerPass='loongson'
#--------------------------------------------

AutoTestDir='/AutoTest'
ServerTestDir='autotest_result'
#--------------------------------------------
time_dir=Time_Begin
#--------------------------------------------
#items_count=3
#--------------------------------------------

#--------------------------------------------
#判断输入参数
#--------------------------------------------
if [ $# -ne 3 ];then
   echo "usage: $0 TestType Platform TestCase" 
   exit 0
fi

#--------------------------------
source ./ini_operation.sh
readIni=$readIni
#--------------------------------

TestType="$1"
Platform="$2"
TestCase="$3"

#--------------------------------------------
retCode=0
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
IPListIniFile='ip_list.ini'
ip_list_path=${resultsPath}/${TestType}/${Platform}/${IPListIniFile}
echo "ip_list_path is:$ip_list_path"


rm -rf $testcaseDir/$TestCase
mkdir -p $testcaseDir/$TestCase
testcase_ip_path="$testcaseDir/$ipList_TestCase_File"
testcase_ip_path_tmp="$testcaseDir/$tmpipList_TestCase_File"

#每次执行程序，都把之前生成的ip列表文件删除,重新生成一次，方便ip改变后，及时更新
rm -rf $testcase_ip_path

#-----------------------------------
#函数功能:
#生成每个测试用例对应的ip列表文件
#-----------------------------------
function writeIPFile()
{
   if [ $# -ne 1 ];then
     echo "usage: writeIPFile opt_name"
     return
   fi

   retCode=0
   opt_name="$1"

   count_items=$(cat node_count.cfg)
   echo count_items is:$count_items 

   for((i=1;i<=count_items;i++));
   do
     NodeNum=$i
     Group_num=$(sh get_GroupNum.sh $TestType $opt_name)
     sectionName="Group${Group_num}"
     keyName="ip_${NodeNum}"
     #echo "第[$i] 个keyName:$keyName"
     IP_testcase=$(readIni $ip_list_path $sectionName $keyName)
     echo 第[$i]个ip:$IP_testcase
     echo $IP_testcase  >>  $testcase_ip_path
   done

}

#------------------------------------------------------------
#函数功能:
#生成每个测试用例对应的所有节点对应的测试信息(测试开始时间)
#------------------------------------------------------------
make_TestInfo()
{

    if [ $# -ne 1 ];then
      echo "usage: make_TestInfo TestName"
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
         
        #sshpass -p $ServerPass scp -o StrictHostKeychecking=no -r \
        #$ServerUser@$ServerIP:~/$ServerTestDir/$TestName/*_${host}.out ${testcaseDir}/${TestName}
        #将原有逻辑scp的方式修正为提前下载，本地筛选的方式,防止网络性能差等导致的程序可用性差的问题
        retCode=0
        \cp ${AutoTestDir}/$ServerTestDir/$TestName/${time_dir}/*_${host}.out ${testcaseDir}/${TestName} || (echo "${host}.out Not exists!"; retCode=1);

        if [ ${retCode} -ne 0 ];then
           echo "Node:[${host}]:Get time file failed."
           \cp $workdir/StdTestInfo.ini "$destPath/Node${i}_${host}.ini" -f
           continue
        fi

        echo "-----------------------获取测试信息文件---------------------------"

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

    done < $testcase_ip_path_tmp

    return 0
}


rm -rf $testcase_ip_path

#-----------------------------
#调用函数,生成ip列表文件
#-----------------------------
writeIPFile $TestCase

#Delete the space lines and comment lines
sed '/^#.*\|^[[:space:]]*$/d' $testcase_ip_path > $testcase_ip_path_tmp

#-------------------------------------------
#调用函数,生成所有测试用例对应节点的系统信息
#-------------------------------------------
make_TestInfo $TestCase

rm -rf $testcase_ip_path_tmp

echo "--------------------------------------------------------"
