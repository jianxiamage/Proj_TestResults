#!/bin/bash


if [ $# -ne 2 ];then
   echo "usage: $0 TestType TestCase" 
   exit 1
fi

#--------------------------------
source ./ini_operation.sh
readIni=$readIni
#--------------------------------
TestType=$1
TestCase=$2
#--------------------------------
#-------------------------------------------------------------------------
TestcasePath='/data/'
GroupIniFile="TestcaseGroup_${TestType}.ini"
TestcaseGroupPath="${TestcasePath}${TestType}/${GroupIniFile}"
#-------------------------------------------------------------------------

sectionName=GroupNum
readIni $TestcaseGroupPath $sectionName $TestCase

