#!/bin/bash
#set -e

#---------------------------------------------------------------------
#功能：
#单线程获取测试日志信息文件
#本地首先同步远程测试节点上的日志目录，如没有同步就会退出程序
#---------------------------------------------------------------------

if [ $# -ne 2 ];then
 echo "usage: $0 TestType Platform" 
 exit 1
fi

#----------------------------------------------------------------------------------------
TestType="$1"
Platform="$2"
#-------------------------------------------------
logFile="GetLog_${TestType}_${Platform}.log"
#-------------------------------------------------
source ../Common_Func/create_LogFile.sh $logFile
#-------------------------------------------------

#----------------------------------------------------------------------------------------
TestListFile="../Init_Env/TestCaseList/TestCaseList_${TestType}.txt"
#----------------------------------------------------------------------------------------
#----------------------------------------------------------------------------------------
AutoTestDir="/AutoTest"  #本地备份目录
DestPath=${AutoTestDir}/TestLog_Dir/${TestType}_${Platform}  #同步到本地服务器的目录
StatePath=${AutoTestDir}/NodeState_Dir/${TestType}_${Platform}          #存放节点状态文件到本地目录
#----------------------------------------------------------------------------------------

function write_outputInfo()
{
  if [ $# -ne 2 ];then
    echo "usage: $0 retCode caseName" 
    return 1
  fi

  retCode=$1
  caseName=$2

  case $retCode in

    0)
       cmdStr="OK,[${TestType}],[Platform],[${caseName}] getting log info succeeded!"
       echo $cmdStr
       write_log "INFO" "${cmdStr}"

       ;;
    2)
       cmdStr="ERROR,[${TestType}],[Platform],[${caseName}] --> No Synchronize log directory!"
       echo $cmdStr
       write_log "ERROR" "${cmdStr}"

       ;;
    3)
       cmdStr="ERROR,[${TestType}],[Platform],[${caseName}] --> No test node state directory!"
       echo $cmdStr
       write_log "ERROR" "${cmdStr}"

       ;;
    *)
       cmdStr="ERROR,[${TestType}],[Platform],[${caseName}] --> Some unknown error occured!!"
       echo $cmdStr
       write_log "ERROR" "${cmdStr}"
       ;;
  esac

  return 0;
}


if [ ! -s $TestListFile ]
then
  cmdStr="Error,File $TestListFile is not Existed!"
  echo $cmdStr
  write_log "ERROR" "${cmdStr}"
  exit 1
fi

#对于远程测试节点log目录判断是否从远程服务器同步到本地服务器
if [ ! -d ${DestPath} ]
then
  cmdStr="Error,The log directory of the remote test node has not been synchronized to the local server!"
  echo $cmdStr
  write_log "ERROR" "${cmdStr}"
  exit 1
fi

#获取远程测试节点在线状态
sh Get_NodeState_Multi.sh ${TestType} ${Platform}

#对于远程测试节点在线状态尚未进行判断,如失败则退出
if [ ! -d ${StatePath} ]
then
  cmdStr="Error,Remote test node status has not been detected!"
  echo $cmdStr
  write_log "ERROR" "${cmdStr}"
  exit 1
fi

#----------------------------------------------------------------------------------------
cmdStr="OK,[${TestType}],[${Platform}],getting the OS Info of the test nodes Begin==================="
echo $cmdStr
write_log "INFO" "${cmdStr}"


start_time=`date +%s`              #定义脚本运行的开始时间

case_count=0
for line in `cat ${TestListFile}`
do
{
  case_name=$line
  echo "当前测试用例:$case_name" 
  sh get_LogInfo.sh $TestType $Platform ${case_name}
  retCode=$?
  #根据执行结果不同返回值，写入不同的log信息,记录程序的运行状况
  write_outputInfo ${retCode} ${case_name}

}
done

echo "***************************************************"
stop_time=`date +%s`  #定义脚本运行的结束时间

echo "***************************************************"
echo "Exec Time:`expr $stop_time - $start_time`s"
echo "***************************************************"

#-------------------------------------------------------------------------------
cmdStr="OK,[${TestType}],[${Platform}],getting the OS Info of the test nodes End==================="
echo $cmdStr
write_log "INFO" "${cmdStr}"
