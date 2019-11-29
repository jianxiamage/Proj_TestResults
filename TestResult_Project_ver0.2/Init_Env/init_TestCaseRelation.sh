#!/bin/bash

#将测试用例对应关系文件拷贝到指定目录下
srcCaseFile='TestCaseRelation.file'

ResultPath='/data'
mkdir $ResultPath -p

echo "copy the [$srcCaseFile] to dest Dir"

\cp $srcCaseFile $ResultPath -f

echo "copy the [$srcCaseFile] to dest Dir End."
