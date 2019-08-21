#!/usr/bin/env python
#coding=utf-8
import csv

with open('./dict.csv', 'r') as f:
  reader = csv.reader(f)
  dic.get('stressapp', 0)

  # python 2
  header = reader.next()
  # python 3x 使用python内置的next
  #  header = next(reader)
  #获取真正的数据
  for row in reader:
    print(row) # 打印每一行，列表类型，只能按位置索引
