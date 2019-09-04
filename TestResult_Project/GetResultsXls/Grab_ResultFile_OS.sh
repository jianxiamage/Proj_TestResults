#!/bin/bash
set -e

#if [ $# -ne 3 ];then
# echo "usage: $0 TestType Platform TestCase" 
# exit 1
#fi

#----------------------------------------------------------------------------------------
#测试类型:"OS" -->操作系统

#测试平台:[7A,7A_Integrated,7A_2way,780,2K]
#目前支持5个平台
#----------------------------------------------------------------------------------------

sh Grab_ResultFile_OS_7A.sh

sh Grab_ResultFile_OS_7A_Integrated.sh

sh Grab_ResultFile_OS_7A_2way.sh

sh Grab_ResultFile_OS_780.sh

sh Grab_ResultFile_OS_2K.sh





