#!/bin/sh
git status
read arg
echo $arg
if [ $arg == 1 ]
then
   git add .
else
   return
fi
git commit -m$1
git log
read q