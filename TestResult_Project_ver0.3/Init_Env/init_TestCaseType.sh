#!/bin/bash

#将测试用例对应标记文件拷贝到指定目录下
#标记为1,则需要在前端页面显示测试开始时间，否则不需要
#加入此功能的原因：
#对于一些性能稳定性测试，其测试时间较长，不知其何时开始终止，
#加入此功能，可以看出测试是何时开始的
srcCaseFile='TestCaseType.txt'

ResultPath='/data'
mkdir $ResultPath -p

echo "copy the [$srcCaseFile] to dest Dir"

\cp $srcCaseFile $ResultPath -f

echo "copy the [$srcCaseFile] to dest Dir End."
