#!/bin/env bash
git fetch upstream
localBranch=`git branch --show-current`
remoteBranchList=`git branch -r`
branch=`echo "${remoteBranchList}" | grep  "upstream/.*${localBranch}"`
git rb ${branch}

