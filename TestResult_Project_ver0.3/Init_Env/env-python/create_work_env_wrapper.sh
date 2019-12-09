#!/bin/bash　　

#查看是否存在要创建的虚拟目录，如果没有旧创建
if [ ! -d "/home/work" ]; then
  echo "/home/work Not Exist, build it"
  mkdir /home/work
else
  echo "/home/work already exists"
fi

pushd .

cd /home/work/

rm -rf *

#install pip
yum -y install python-pip

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


