#!/bin/bash

#----------------------------------------
if [ $# -ne 1 ];then
 echo "usage: $0 LogFileName" 
 exit 1
fi

FileName=$1

#----------------------------------------
logPath=/var/log/Log_TestResult
logFile=${logPath}/${FileName}
#----------------------------------------

mkdir -p $logPath

#=================================================================

#log Function 
function write_log()
{
  local logType=$1
  local logMsg=$2
  #local logName=$3
  echo "[$logType : `date +%Y-%m-%d\ %T`] : $logMsg" >> $logFile
}
