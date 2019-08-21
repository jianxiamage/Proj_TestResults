#!/usr/bin/env bash

echo "当前路径文件:"
ls
echo "开始删除本目录下的pyc文件..."
rm -rf *.pyc

echo "删除本目录下的pyc文件完成."

echo "当前路径文件:"
ls
