#!/bin/bash

#/data/TestResults.ini

ResultPath='/data'
ResultPathFile='TestResultFilePath.ini'


destPath='/data/TestResultFilePath.ini'


mkdir $ResultPath -p

echo ----------------------------------------------------

if [ -s $destPath ];then
  echo "Good! [$destPath] is existed."
else
  echo "The current file [ResultPathFile] will be copied to [$ResultPath]"
  \cp $ResultPathFile $ResultPath -f
  echo "copy file [$destPath] successed."
fi

echo ----------------------------------------------------

