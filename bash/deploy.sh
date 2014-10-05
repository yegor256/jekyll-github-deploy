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
VERSION=$(git describe --always --tag)

echo -e "\nBuilding Jekyll site:"
rm -rf _site

if [ -r _config-deploy.yml ]; then
  jekyll build --config _config.yml,_config-deploy.yml
else
  jekyll build
fi

if [ ! -e _site ]; then
  echo -e "\nJekyll didn't generate anything in _site!"
  exit -1
fi

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
git commit -am "new site version ${VERSION} deployed" --allow-empty
git push origin gh-pages 2>&1 | sed 's|'$URL'|[skipped]|g'

echo -e "\nCleaning up:"
rm -rf "${CLONE}"
rm -rf "${SITE}"
