#!/bin/env bash
git fetch upstream
git stash
localBranch=`git branch --show-current`
remoteBranchList=`git branch -r`
branch=`echo "${remoteBranchList}" | grep  "upstream/.*${localBranch}"`
result=`git rb ${branch}`
echo $result
read q

