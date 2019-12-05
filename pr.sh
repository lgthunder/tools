#!/bin/sh
git stash
git fetch upstream
git rebase upstream/release_zbb_master
git log
read q
