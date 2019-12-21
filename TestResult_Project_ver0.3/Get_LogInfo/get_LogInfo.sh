#!/bin/bash

#--------------------------------------------
NodeUser='root'
NodePass='loongson'
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
OSInfoDir="LogInfo"
destPath="${resultsPath}/${TestType}/${Platform}/${detailDir}/${OSInfoDir}/$TestCase"
rm -rf $destPath
mkdir $destPath -p
#--------------------------------------------
ipList_TestCase_File="ipList_${TestCase}.txt"
tmpipList_TestCase_File="${ipList_TestCase_File}.tmp"
#--------------------------------------------
#-------------------------------------------------------------------------------------------------
AutoTestDir="/AutoTest"  #本地备份目录
StatePath=${AutoTestDir}/NodeState_Dir/${TestType}_${Platform}          #存放节点状态文件到本地目录
#StateFile=${DestPath}/${NodeIP}_StateFile.txt  #同步到本地对应节点状态文件
#-------------------------------------------------------------------------------------------------

#------------------------------------------------------
DestPath=${AutoTestDir}/TestLog_Dir/${TestType}_${Platform}  #同步到本地服务器的目录
#------------------------------------------------------
test_name=${TestCase}
test_logDir=""
test_logFile=""
#------------------------------------------------------

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

maxsize_M=1                        #查看是否大于1M
maxsize=$((1024*1024*$maxsize_M))  #转换为字节

function writeIPFile()
{
   if [ $# -ne 1 ];then
     echo "usage: writeIPFile opt_name"
     return
   fi

   retCode=0
   opt_name="$1"
   #opt_num="$2"

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
     #echo 第[$i]个ip:$IP_testcase
     #记录每个测试用例对应的ip列表到一个文件中
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
    {
        let i++

        workdir=$(cd $(dirname $0); pwd)

        echo 第[$i]个ip:$host
        NodeIP=$host
        test_logDir="${DestPath}/${NodeIP}_LogDir/Test_Log/${test_name}"
        test_logFile="${test_logDir}/${test_name}.log"

        echo "-------------------------------------------------------------------------------------------------------" > "$destPath/Node${i}_${host}.txt"

        StateFile=${StatePath}/${NodeIP}_StateFile.txt  #同步到本地对应节点状态文件
        echo "=========================$StateFile"
        if [ ! -s ${StateFile} ];
        then
          echo "$StateFile is not existed!"
          echo "${host} state:Unknown" >> "$destPath/Node${i}_${host}.txt"
        else
          #首先将获取的目标节点的状态信息填入
          cat $StateFile >> "$destPath/Node${i}_${host}.txt"
        fi
        
        echo "-------------------------------------------------------------------------------------------------------" >> "$destPath/Node${i}_${host}.txt"

        if [ ! -s ${test_logFile} ];
        then
          echo "[${TestType}],[${Platform}],[${TestCase}]:No log file exists!"
          #\cp StdLogInfo.txt "$destPath/Node${i}_${host}.txt" -f
          echo "Maybe the test case [${TestCase}] is not beginning!" >> "$destPath/Node${i}_${host}.txt"
          continue
        fi

        echo "" >> "$destPath/Node${i}_${host}.txt"
        echo "========================================The test log is as follows=====================================" >> "$destPath/Node${i}_${host}.txt"

        logSizeLine=`ls -l ${test_logFile}`
        echo "logSizeLine is: ${logSizeLine}"
        logSize=`echo ${logSizeLine} | awk '{ print $5 }'`
        echo "logSize is: ${logSize}"
        if [ $logSize -gt $maxsize ]
        then
          echo "[${TestCase}]: LogSize > ${maxsize_M}M"
          head -n 20 ${test_logFile} >> "$destPath/Node${i}_${host}.txt"

          echo "====================================================================================" >> "$destPath/Node${i}_${host}.txt"
          echo "=====================源Log文件较大,只显示前20行和后20行=============================" >> "$destPath/Node${i}_${host}.txt"
          echo "====================================================================================" >> "$destPath/Node${i}_${host}.txt"

          tail -n 20 ${test_logFile} >> "$destPath/Node${i}_${host}.txt"
          continue
        else
          echo "[${TestCase}]: LogSize < ${maxsize_M}M"
        fi

        #\cp ${test_logFile} "$destPath/Node${i}_${host}.txt" -f
        cat ${test_logFile} >> "$destPath/Node${i}_${host}.txt"
         
        #if [ $? -ne 0 ];then
        #  \cp StdLogInfo.txt "$destPath/Node${i}_${host}.txt" -f
        #  echo "cp log file failed!" > "$destPath/Node${i}_${host}.txt"
        #fi
   }
   done < $testcase_ip_path_tmp

   return 0
}


#对于远程测试节点log目录判断是否从远程服务器同步到本地服务器
if [ ! -d ${DestPath} ]
then
  echo "The log directory of the remote test node has not been synchronized to the local server!"
  exit 2
fi

#对于远程测试节点在线状态尚未进行判断
if [ ! -d ${StatePath} ]
then
  echo "Remote test node status has not been detected!"
  exit 3
fi


writeIPFile $TestCase

#Delete the space lines and comment lines
sed '/^#.*\|^[[:space:]]*$/d' $testcase_ip_path > $testcase_ip_path_tmp

check_result $TestCase

rm -rf $testcase_ip_path_tmp
rm -rf $testcase_ip_path

echo "--------------------------------------------------------"
