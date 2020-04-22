#!/bin/bash

echo "递归删除所有pyc文件"
find . -name "*.pyc"  | xargs rm -f


echo "删除临时日志文件"
rm -rf */Log_*
rm -rf */TestMark_*
