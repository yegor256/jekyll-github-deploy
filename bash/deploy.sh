#!/bin/bash
set -x
set -e
set -o pipefail

URL=$1
BRANCH=$2
SRC=$(pwd)
TEMP=$(mktemp -d -t mgd-XXX)
trap 'rm -rf ${TEMP}' EXIT
CLONE=${TEMP}/clone
COPY=${TEMP}/copy

echo -e "Cloning Github repository:"
git clone "${URL}" "${CLONE}"
cp -R "${CLONE}" "${COPY}"

cd "${CLONE}"

echo -e "\nBuilding Middleman site:"
rm -rf build
middleman build

if [ ! -e build ]; then
  echo -e "\nMiddleman didn't generate anything in build!"
  exit -1
fi

cp -R build "${TEMP}"

cd "${TEMP}"
rm -rf "${CLONE}"
mv "${COPY}" "${CLONE}"
cd "${CLONE}"

echo -e "\nPreparing ${BRANCH} branch:"
if [ -z "$(git branch -a | grep origin/${BRANCH})" ]; then
  git checkout --orphan "${BRANCH}"
else
  git checkout "${BRANCH}"
fi

echo -e "\nDeploying into ${BRANCH} branch:"
rm -rf *
cp -R ${TEMP}/build/* .
rm -f README.md
git add .
git commit -am "new version $(date)" --allow-empty
git push origin "${BRANCH}" 2>&1 | sed 's|'$URL'|[skipped]|g'

echo -e "\nCleaning up:"
rm -rf "${CLONE}"
rm -rf "${SITE}"
