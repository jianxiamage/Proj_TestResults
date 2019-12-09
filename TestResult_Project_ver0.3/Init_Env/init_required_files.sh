#!/bin/bash
set -e

HelpFile='ReadMe.txt'

ResultPath='/data'
echo copy the [$HelpFile] to dest Dir

destPath=$ResultPath

mkdir $ResultPath -p
 
\cp $HelpFile $destPath -f || { echo "Error,copy help file failed!";exit 1; }

echo ----------------------------------------------------

