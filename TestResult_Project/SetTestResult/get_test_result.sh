#!/bin/bash

#--------------------------------------------
ServerIP='auto_test.loongson.cn'
ServerUser='loongson-test'
ServerPass='loongson'
#--------------------------------------------

ServerTestDir=autotest_result
TestName="stressapp"
TestGroupNum=2
okfile='ok_file.txt'
errfile='err_file.txt'
#--------------------------------------------
items_count=3
#--------------------------------------------
ipList_stressappFile='ipList_stressapp.txt'
tmpipList_stressappFile="${ipList_stressappFile}.tmp"
#--------------------------------------------

testcaseDir="7A"
mkdir -p $testcaseDir
#--------------------------------------------
check_result()
{
    exec 3< $testcaseDir/$tmpipList_stressappFile
    while read host <&3
    do
        echo "--------------------------------------------------------"
        sshpass -p $ServerPass scp -o StrictHostKeychecking=no -r $ServerUser@$ServerIP:~/$ServerTestDir/$TestName/$host-* ${testcaseDir} || echo error > $errfile
        echo [$host] test OK.
    done < $testcaseDir/$tmpipList_stressappFile

    return 0
}





#IP_1_stressapp=`python get_ip.py 2 1`
#echo $IP_1_stressapp
rm -rf $testcaseDir/$ipList_stressappFile

for((i=1;i<=items_count;i++));
do
  IP_stressapp=`python get_ip.py $TestGroupNum $i`
  echo 第[$i]个ip:$IP_stressapp
  echo $IP_stressapp  >>  $testcaseDir/$ipList_stressappFile
done

#Delete the space lines and comment lines
sed '/^#.*\|^[[:space:]]*$/d' $testcaseDir/$ipList_stressappFile > $testcaseDir/$tmpipList_stressappFile


check_result

echo "--------------------------------------------------------"

#sshpass -p $ServerPass scp -o StrictHostKeychecking=no -r $ServerUser@$ServerIP:~/$ServerTestDir/$TestName/$IP_1_stressapp-* ${testcaseDir} || echo error > $errfile
#sshpass -p $ServerPass scp -o StrictHostKeychecking=no -r $ServerUser@$ServerIP:~/$ServerTestDir/$TestName/$IP_2_stressapp-* ${testcaseDir} || echo error > $errfile
#sshpass -p $ServerPass scp -o StrictHostKeychecking=no -r $ServerUser@$ServerIP:~/$ServerTestDir/$TestName/$IP_3_stressapp-* ${testcaseDir} || echo error > $errfile



