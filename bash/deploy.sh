#!/bin/bash
set -e

URL=$1
SRC=$(pwd)
TEMP=$(mktemp -d -t jgd-XXX)
trap "rm -rf ${TEMP}" EXIT
CLONE=${TEMP}/clone

echo -e "Cloning Github repository:"
git clone "${URL}" "${CLONE}"

echo -e "\nBuilding Jekyll site:"
cd "${CLONE}"
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
rm README.md
git add .
git config user.email "jgd@teamed.io"
git config user.name "jekyll-github-deploy"
git commit -am "new site version deployed" --allow-empty
git push origin gh-pages 2>&1 | sed 's|'$URL'|[skipped]|g'

echo -e "\nCleaning up:"
rm -rf "${CLONE}"
rm -rf "${SITE}"
