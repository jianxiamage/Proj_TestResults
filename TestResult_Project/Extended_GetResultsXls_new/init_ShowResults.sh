#!/bin/bash

#/data-std/TestResults.ini

resultsPath=$(cat data_path.txt)
resultsPathFile='TestResultFilePath.ini'


destPath='/data-std/TestResultFilePath.ini'

#rm -rf /IPList

mkdir $resultsPath -p

echo ----------------------------------------------------

if [ -s $destPath ];then
  echo "Good! [$destPath] is existed."
else
  echo "The current file [resultsPathFile] will be copied to [$resultsPath]"
  \cp $resultsPathFile $resultsPath -f
  echo "copy file [$destPath] successed."
fi

echo ----------------------------------------------------

