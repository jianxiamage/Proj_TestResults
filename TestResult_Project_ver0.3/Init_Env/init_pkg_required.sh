#!/bin/bash

echo "----------------------------------------------------"

yum install sshpass -y

if [ $? -ne 0 ];
then
  echo "Error!Installing the sshpass failed."
  exit 1
fi

echo "----------------------------------------------------"

