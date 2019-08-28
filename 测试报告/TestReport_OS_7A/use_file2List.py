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

    for test_suite in package_tests:
        for test_case in test_suite:
            testunit.addTests(test_case)
            test_str=str(test_case)
            write_file(test_str)
            ret_code,ret_str = exec_cmd()
            if ret_str == str_case:
               
