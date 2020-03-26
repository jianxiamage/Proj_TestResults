#!/bin/bash　　

#-------------------------------------
work_dir=/home/work
#-------------------------------------

#-------------------------------------
#install pip
yum -y install python-pip
#-------------------------------------

#查看是否存在要创建的虚拟目录，如果没有旧创建
if [ ! -d "${work_dir}" ]; then
  echo "${work_dir} Not Exist, build it"
  mkdir $work_dir
else
  echo "${work_dir} already exists"
  echo "python virtual env already exists"
  exit 0
fi

pushd .

cd $work_dir

#rm -rf *

echo "---------------------------------"
echo 'installing virtualenvwrapper...'
echo "---------------------------------"
pip install virtualenvwrapper

export WORKON_HOME=/home/work/env-wrapper

echo "---------------------------------"
echo 'active the virtualenvwrapper'
echo "---------------------------------"
source /usr/bin/virtualenvwrapper.sh

echo "---------------------------------"
echo 'creating the virtual environment:env-excel...'
echo "---------------------------------"
mkvirtualenv env-excel

echo "---------------------------------"
echo 'creating the virtual environment:env-report...'
echo "---------------------------------"
mkvirtualenv env-report

echo "---------------------------------"
echo 'creating the virtual environment:env-database...'
echo "---------------------------------"
mkvirtualenv env-database


echo "---------------------------------"
echo 'show virtual environment:'
echo "---------------------------------"
lsvirtualenv -b

popd

#激活虚拟环境，进行初始化操作（按照必须的包）
export WORKON_HOME=/home/work/env-wrapper

echo ---------------------------------
echo 'active the virtualenvwrapper'
echo ---------------------------------
source /usr/bin/virtualenvwrapper.sh

echo ---------------------------------
echo 'change to virtualenv:env-excel'
echo ---------------------------------
workon env-excel

echo "Installing the required packages for the function of Excel."
pwd
#pip install xlwt
#pip install xlrd
#pip freeze > ./requirements.txt
#cat requirements.txt
pip install -r requirements.txt

echo ---------------------------------
echo 'change to virtualenv:env-report'
echo ---------------------------------
workon env-report

env_dir="/home/work/env-wrapper"
report_pkgDir="${env_dir}/env-report/lib/python2.7/site-packages"
cp ExtentHTMLTestRunner.py ${report_pkgDir}
cp HTMLTestRunnerCN.py ${report_pkgDir}
cp HTMLTestRunner.py ${report_pkgDir}

echo ---------------------------------
echo 'change to virtualenv:env-excel'
echo ---------------------------------
workon env-database

#安装MySQL驱动前要安装必要的包
#yum install python-devel -y
pip install MySQL-python


echo "------------------------------------------------------------------"
echo "OK,Now the python virtual environment is successfully completed."
echo "------------------------------------------------------------------"
