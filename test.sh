#!/bin/bash
set -e
set -x

TMP=$(mktemp -d -t jgd-XXXX)

CWD=$(pwd)
git init "${TMP}"
cd "${TMP}"
echo "hello" > "test.html"
git add "test.html"
git config user.email "test@example.com"
git config user.name "Test"
git commit -am 'initial commit'
cd "${CWD}"

./bash/deploy.sh "${TMP}"
rm -rf "${TMP}"
