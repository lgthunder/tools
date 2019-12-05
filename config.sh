#!/usr/bin/env bash

root=`pwd`
buildPath=${root}/config.gradle
#1  hecha 修改
if ! $1
then
sed -i.bak s#'HE_CHA   :  "open"'#'HE_CHA   :  "close"'#g ${buildPath}
fi

#2  kankan 修改
if ! $2
then
sed -i.bak s#'KAN_KAN  :  "open"'#'KAN_KAN  :  "close"'#g ${buildPath}
fi
if [ -f ${buildPath}.bak ]
then
rm ${buildPath}.bak
fi







