#!/bin/sh
git stash
git fetch upstream
git rebase upstream/newzbb/zew_zbb_dev
git log
read q
