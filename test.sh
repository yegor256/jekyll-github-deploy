#!/bin/bash
set -e
set -x

TMP=$(mktemp -d -t jgd-XXXX)

CWD=$(pwd)
git init "${TMP}"
cd "${TMP}"
echo "hello" > "test.html"
git add "test.html"
git commit -am 'initial commit'
cd "${CWD}"

./bash/deploy.sh "${TMP}"
rm -rf "${TMP}"
