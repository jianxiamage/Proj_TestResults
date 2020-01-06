#!/bin/bash

#--------------------------------------------
ServerIP='auto_test.loongson.cn'
ServerUser='loongson-test'
ServerPass='loongson'
#--------------------------------------------
AutoTestDir='/AutoTest'
ServerTestDir='autotest_result'
#--------------------------------------------
#items_count=3
#--------------------------------------------

if [ $# -ne 3 ];then
   echo "usage: $0 TestType Platform TestCase" 
   exit 0
fi

#--------------------------------
source ./ini_operation.sh
readIni=$readIni
#--------------------------------

#--------------------------------------------
TestType="$1"
Platform="$2"
TestCase="$3"
#--------------------------------------------
retCode=0
onLineFlag=0
#--------------------------------------------
resultsPath="/data"
detailDir="Detail"
OSInfoDir="OSInfo"
destPath="${resultsPath}/${TestType}/${Platform}/${detailDir}/${OSInfoDir}/$TestCase/"
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
   #opt_num="$2"

   #count_items=`python get_node_count.py $opt_name`

   #count_items=`python -c "import get_node_count;get_node_count.getSectionCount($opt_name)"`
   #count_items=$(python -c 'import get_node_count; print get_node_count.getSectionCount("'$TestType'","'$Platform'","'$opt_name'")')
   count_items=$(cat node_count.cfg)
   echo count_items is:$count_items 
  
   #readIni $TestcaseGroupPath $sectionName $TestCase

   for((i=1;i<=count_items;i++));
   do
     NodeNum=$i
     #IP_testcase=`python get_node_ip.py $opt_name $i`
     #IP_testcase=$(python -c 'import get_node_ip; print get_node_ip.getResult("'$TestType'","'$Platform'","'$opt_name'","'$i'")')
     Group_num=$(sh get_GroupNum.sh $TestType $opt_name)
     sectionName="Group${Group_num}"
     keyName="ip_${NodeNum}"
     #echo "第[$i] 个keyName:$keyName"
     IP_testcase=$(readIni $ip_list_path $sectionName $keyName)
     #echo 第[$i]个ip:$IP_testcase
     #记录每个测试用例对应的ip列表到一个文件中
     echo $IP_testcase  >>  $testcase_ip_path
   done


#   for((i=1;i<=count_items;i++));
#   do
#     #IP_testcase=`python get_node_ip.py $opt_name $i`
#     IP_testcase=$(python -c 'import get_node_ip; print get_node_ip.getResult("'$TestType'","'$Platform'","'$opt_name'","'$i'")')
#     echo 第[$i]个ip:$IP_testcase
#     echo $IP_testcase  >>  $testcase_ip_path
#   done

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
        #ping -c3 -i0.3 -W1 $host &>/dev/null
        #if [ $? -ne 0 ] ;then
        #  echo "[${host}] can not be connected!"
        #  onLineFlag=1
        #  \cp $workdir/StdOSInfo.ini "$destPath/Node${i}_${host}.ini" -f
        #  continue
        #fi

        #sshpass -p $ServerPass scp -o StrictHostKeychecking=no  \
        #$ServerUser@$ServerIP:~/$ServerTestDir/$TestName/OS_Info/${TestName}_${host}_osinfo.txt "$destPath/Node${i}_${host}.ini"

        \cp ${AutoTestDir}/$ServerTestDir/OS_Info/${host}_osinfo.txt "$destPath/Node${i}_${host}.ini" -f
        #(echo "${TestName}_${host}_osinfo.txt Not exists!"; retCode=1);
        retCode=$?

        if [ $retCode -ne 0 ];then
           echo "${TestName}_${host}_osinfo.txt Not exists!"
           echo "Node:[${host}]:Get OS Info file failed."
           \cp $workdir/StdOSInfo.ini "$destPath/Node${i}_${host}.ini" -f
           continue
        fi

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
