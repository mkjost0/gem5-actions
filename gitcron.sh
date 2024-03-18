#!/bin/sh
cd vm-testing/gem5-actions
git pull upstream develop
git push -f --mirror origin
