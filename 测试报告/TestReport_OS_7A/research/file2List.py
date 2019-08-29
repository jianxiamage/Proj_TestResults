#!/usr/bin/env python
#coding=utf-8

import sys
result=[]
with open('Std_CaseList.txt','r') as f:
    for line in f:
        result.append(list(line.strip('\n').split(',')))
#print(result)

for i in xrange(len(result)):
     print i, result[i]
     str_wget = ''.join(result[i])
     if str_wget == 'wget':
       print('find the key:wget')

print('-----------')
print(result[1])
print('-----------')
str_wget=''.join(result[1])
print(str_wget)
print('-----------')
#for i in result:
#    print i
#    if str(i) == 'wget':
#      print('find the key:wget')
