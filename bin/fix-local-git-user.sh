#!/bin/bash

git status >/dev/null 2>&1
if [[ $? -ne 0 ]]; then
    echo "Not in a git repository: PWD is ${PWD}"
    exit 1
fi

set -x
git config --local user.name "Luis Armendariz"
git config --local user.email luis.armendariz@gmail.com
