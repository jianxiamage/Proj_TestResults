#!/bin/bash
set -e

#if [ $# -ne 3 ];then
# echo "usage: $0 TestType Platform TestCase" 
# exit 1
#fi

#----------------------------------------------------------------------------------------
#测试类型:"Kernel" -->内核

#测试平台:[7A,7A_Integrated,7A_2way,780,2K,3A_4000]
#目前支持6个平台
#----------------------------------------------------------------------------------------

sh Create_Result_Excel_Kernel_2K.sh

sh Create_Result_Excel_Kernel_780.sh

sh Create_Result_Excel_Kernel_7A_2way.sh

sh Create_Result_Excel_Kernel_7A_Integrated.sh

sh Create_Result_Excel_Kernel_7A.sh

sh Create_Result_Excel_Kernel_3A_4000.sh
