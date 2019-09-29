#!/bin/bash
set -e

#if [ $# -ne 3 ];then
# echo "usage: $0 TestType Platform TestCase" 
# exit 1
#fi

#----------------------------------------------------------------------------------------
#测试类型:"KVM" -->KVM

#测试平台:[7A,7A_Integrated,7A_2way,780,2K,3A_4000]
#目前支持6个平台
#----------------------------------------------------------------------------------------

sh Grab_ResultFile_KVM_2K.sh

sh Grab_ResultFile_KVM_780.sh

sh Grab_ResultFile_KVM_7A_2way.sh

sh Grab_ResultFile_KVM_7A_Integrated.sh

sh Grab_ResultFile_KVM_7A.sh

sh Grab_ResultFile_KVM_3A_4000.sh
