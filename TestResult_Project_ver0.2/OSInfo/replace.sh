#!/bin/bash

for file in `ls |grep GetTestInfo`
do
  echo "原文件名:$file"
  newfile=`echo $file |sed "s/GetTestInfo/GetOSInfo/g"`
  echo "新文件名:$newfile"
  echo "------------------------------------------------"
  mv $file $newfile
done
