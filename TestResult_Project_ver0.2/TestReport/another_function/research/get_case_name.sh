#!/bin/bash

#-----------------------------
file_name='tmp_file.txt'
#-----------------------------

input_str=$(cat $file_name)
#echo $a|grep -o '\[.*\]'
firstdo_str=$(echo $input_str | grep -o '\[.*\]')
#echo "截取含有中括号的部分:"
#echo $firstdo_str

left_str=${firstdo_str#*[}
#echo $left_str
 
secdo_str=${left_str%]*}
#echo "去掉两端中括号结果为:"
#echo $secdo_str

#echo $c|awk 'print $1'
ar=(${secdo_str})

key_str=${ar[0]}
#echo $key_str

key=`echo $key_str | awk -F\. '{print $2}'`
#echo "最终结果为:"
echo $key
