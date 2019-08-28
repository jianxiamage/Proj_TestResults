#!/bin/bash

if [ $# -ne 1 ];then
 echo "usage: $0 input_str" 
 exit 1
fi

#a=$(cat case-data.txt)
a=$1
#echo $a|grep -o '\[.*\]'
tmp_str=$(echo $a|grep -o '\[.*\]')
echo "截取含有中括号的部分:"
echo $tmp_str

a=$tmp_str
b=${a#*[}
#echo $b
 
c=${b%]*}
echo "去掉两端中括号结果为:"
echo $c

