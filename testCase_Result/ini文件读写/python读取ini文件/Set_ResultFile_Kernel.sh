#!/bin/bash
set -e

#if [ $# -ne 3 ];then
# echo "usage: $0 TestType Platform TestCase" 
# exit 1
#fi

#----------------------------------------------------------------------------------------
#测试类型:"Kernel" -->内核

#测试平台:[7A,7A_Integrated,7A_2way,780,2K]
#目前支持5个平台
#----------------------------------------------------------------------------------------

sh Set_ResultFile_Kernel_2K.sh

sh Set_ResultFile_Kernel_780.sh

sh Set_ResultFile_Kernel_7A_2way.sh

sh Set_ResultFile_Kernel_7A_Integrated.sh

sh Set_ResultFile_Kernel_7A.sh

