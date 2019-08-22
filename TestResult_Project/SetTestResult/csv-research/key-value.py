#!/usr/bin/env python
#coding=utf-8

import csv


#with open('dict.csv', 'rb') as csv_file:
#    reader = csv.reader(csv_file)
#    mydict = dict(reader)

with open('./dict.csv', 'r') as f:
  reader = csv.DictReader(f, delimeter=':')
  for dic in reader:
    print(dic.items()) # 每行按字典返回，按键索引
