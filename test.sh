#!/bin/bash

# SPDX-FileCopyrightText: Copyright (c) 2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

set -ex -o pipefail

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

./bash/deploy.sh "${TMP}" gh-pages master _some-other-config.yml

cd "${TMP}"
git checkout gh-pages
ls -al
grep "hello" < test.html
cd "${CWD}"
rm -rf "${TMP}"

echo "success"
