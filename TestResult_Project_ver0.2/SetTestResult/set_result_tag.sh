#!/bin/bash

#--------------------------------------------
ServerIP='auto_test.loongson.cn'
ServerUser='loongson-test'
ServerPass='loongson'
#--------------------------------------------

ServerTestDir='autotest_result'
okfile='ok_file.txt'
errfile='err_file.txt'
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

#--------------------------------
source ./ini_operation.sh
readIni=$readIni
#--------------------------------

#--------------------------------------------
resultsPath="/data"
ipList_TestCase_File="ipList_${TestCase}.txt"
tmpipList_TestCase_File="${ipList_TestCase_File}.tmp"
#--------------------------------------------

testcaseDir="${TestType}/${Platform}/${TestCase}"

mkdir -p $testcaseDir
testcase_ip_path="$testcaseDir/$ipList_TestCase_File"
testcase_ip_path_tmp="$testcaseDir/$tmpipList_TestCase_File"

#每次执行程序，都把之前生成的ip列表文件删除,重新生成一次，方便ip改变后，及时更新
rm -rf $testcase_ip_path

IPListIniFile='ip_list.ini'
ip_list_path=${resultsPath}/${TestType}/${Platform}/${IPListIniFile}
echo "ip_list_path is:$ip_list_path"


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

   #readIni $TestcaseGroupPath $sectionName $TestCase
  
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


#--------------------------------------------
check_result()
{

    if [ $# -ne 1 ];then
      echo "usage: check_result TestName"
      return
    fi

    TestName="$1"
    echo "----------------------------------------------------------------------------------------"
    echo Begin to get the state of Test Case:[$TestName],TestType:[$TestType],Platform:[$Platform]
    echo "----------------------------------------------------------------------------------------"
    i=0
    exec 3< $testcase_ip_path_tmp
    while read host <&3
    do
        let i++
        #sshpass -p $ServerPass scp -o StrictHostKeychecking=no -r $ServerUser@$ServerIP:~/$ServerTestDir/$TestName/$host-* ${testcaseDir} || { echo 'Error!'; continue; }
        #if [ "ssh root@${ip} -f filename"
        #初始化测试结果（初值设为1）
        opt_value=1
        #python -c 'import set_test_result; set_test_result.setResult("'$TestType'","'$Platform'","'$TestName'","'$i'","'$opt_value'")'
        python std_rw_ini.py $TestType $Platform $TestName $i $opt_value

        #首先判断远程服务器上本测试用例的结果目录是否只存在一个，否则出错（当前只能存在一个最新的结果）

        count=`sshpass -p $ServerPass  ssh -o StrictHostKeychecking=no $ServerUser@$ServerIP  "ls ~/${ServerTestDir}/${TestName}/ |grep ${host}- |wc -l"` || count=0;
        if [ $count -eq 0 ];
        then
          #echo "There is no result dirs for the Test Case:$TestName.Maybe it is running,Please wait..." 
          echo "[$host],TestType:[${TestType}],Platform:[${Platform}],TestCase:[${TestName}] update state Failed!" >> ${errfile};
          continue
        fi

        #echo "The count of result dirs on the remote server for the Test Case:$TestName is:$count"
        if [ $count -ne 1 ];
        then
          echo "Error!There are more than 1 result dirs for the Test Case:$TestName." 
          continue
        fi

        sshpass -p $ServerPass  ssh -o StrictHostKeychecking=no $ServerUser@$ServerIP \
        "[ -d ~/${ServerTestDir}/${TestName}/${host}-* ]" 
        #if [ $? -ne 0 ];
        #then
        #echo "[$host],TestType:[${TestType}],Platform:[${Platform}],TestCase:[${TestName}] update state Failed!" >> ${errfile};
        #fi

        echo "[$host],TestType:[${TestType}],Platform:[${Platform}],TestCase:[${TestName}] update state OK." >> ${okfile}
        opt_value=0
        #setResult
        #python -c 'import set_test_result; set_test_result.setResult("'$TestType'","'$Platform'","'$TestName'","'$i'","'$opt_value'")'
        python std_rw_ini.py $TestType $Platform $TestName $i $opt_value

    done < $testcase_ip_path_tmp

    return 0
}


rm -rf $testcase_ip_path

#:> ${okfile}
#:> ${errfile}

#writeIPFile stressapp 
writeIPFile $TestCase


#Delete the space lines and comment lines
sed '/^#.*\|^[[:space:]]*$/d' $testcase_ip_path > $testcase_ip_path_tmp


check_result $TestCase

rm -rf $testcase_ip_path_tmp
