#!/bin/bash

_DIR=$(dirname "${0}")

# ${1} is used to insert some parameters to build command like --no-cache
"${_DIR}"/prepare.sh && \
"${_DIR}"/build.sh ${1} && \
"${_DIR}"/check.sh && \
"${_DIR}"/check_versions.sh && \
"${_DIR}"/deploy.sh && \
"${_DIR}"/run.sh
