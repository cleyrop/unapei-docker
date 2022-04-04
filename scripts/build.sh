#!/bin/bash

_DIR=$(dirname "${0}")
#shellcheck source=functions/config.sh
source "${_DIR}/functions/config.sh"
read_config "${_DIR}/../config/image.properties"

# ${1} is used to insert some parameters to build command like --no-cache
DOCKER_BUILDKIT=1 docker build ${1} -t "${CONFIG[name]}:${CONFIG[version]}" "${_DIR}/../docker"
