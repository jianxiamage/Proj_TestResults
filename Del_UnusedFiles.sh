#!/bin/bash
#set -e

echo "递归删除所有pyc文件"
find . -name "*.pyc"  | xargs rm -f

echo "递归删除所有html文件"
find . -name "*.html"  | xargs rm -f
echo ----------------------------------------------------

