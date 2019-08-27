#!/bin/bash

#if [ $# -ne 3 ];then
# echo "usage: $0 TestType Platform TestCase" 
# exit 1
#fi

#----------------------------------------------------------------------------------------
#测试类型:"Kernel"

#测试平台:[7A,7A_Integrated,7A_2way,780,2K]
#目前支持5个平台
#----------------------------------------------------------------------------------------

sh Merge_Excel_Kernel_7A.sh

sh Merge_Excel_Kernel_7A_Integrated.sh

sh Merge_Excel_Kernel_7A_2way.sh

sh Merge_Excel_Kernel_780.sh

sh Merge_Excel_Kernel_2K.sh
