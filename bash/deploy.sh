#!/bin/bash
set -e

URL=$1
SRC=$(pwd)
TEMP=$(mktemp -d -t jgd-XXX)
trap "rm -rf ${TEMP}" EXIT
CLONE=${TEMP}/clone

echo -e "Cloning Github repository:"
git clone "${URL}" "${CLONE}"

echo -e "\nRegistering variables:"
cd "${CLONE}"
USER_EMAIL=$(git config --get user.email)
USER_NAME=$(git config --get user.name)
VERSION=$(git describe --always --tag)

echo -e "\nBuilding Jekyll site:"
rm -rf _site
jekyll build
cp -R _site ${TEMP}

echo -e "\nPreparing gh-pages branch:"
if [ -z "$(git branch -a | grep origin/gh-pages)" ]; then
  git checkout --orphan gh-pages
else
  git checkout gh-pages
fi

echo -e "\nDeploying into gh-pages branch:"
rm -rf *
cp -R ${TEMP}/_site/* .
rm -f README.md
git add .
git config user.email "${USER_EMAIL}"
git config user.name "${USER_NAME}"
git commit -am "new site version ${VERSION} deployed" --allow-empty
git push origin gh-pages 2>&1 | sed 's|'$URL'|[skipped]|g'

echo -e "\nCleaning up:"
rm -rf "${CLONE}"
rm -rf "${SITE}"
