#!/usr/bin/env bash

APP_DIR="/tmp/app"

BRANCH_NAME=$(git symbolic-ref --short HEAD)

if [[ ${BRANCH_NAME} == "master" ]]
then
    VERSION="latest"
else
    # remove the v prefix.
    VERSION="${BRANCH_NAME##v}"
fi

docker run -v ${APP_DIR}:${APP_DIR} -w ${APP_DIR} -it --rm --entrypoint=sh \
    --network infrastructure_network \
    node:10.16.3-stretch -c \
    "npm init -y && npm install -E @bitwarden/cli@${VERSION}"

cp ${APP_DIR}/package{,-lock}.json .

git add .
git commit -m 'Update dependencies.'
