#!/usr/bin/env python
#coding=utf-8

import xlwt
 
workbook = xlwt.Workbook(encoding='utf-8')
booksheet = workbook.add_sheet('Sheet 1', cell_overwrite_ok=True)
#存第一行第一列cell(0,0)
booksheet.write(0,0,34)

#存第一行第二列cell(1,0)
booksheet.write(1,0,36)

#存第一行第三列cell(2,0)
booksheet.write(2,0,38)

#存一列数据
rowdata = [43,56,78]

for i in range(len(rowdata)):
    booksheet.write(i,2,rowdata[i])
workbook.save('example.xls')
