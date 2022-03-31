#!/bin/bash

_DIR=$(dirname "${0}")
#shellcheck source=functions/config.sh
source "${_DIR}/functions/config.sh"
read_config "${_DIR}/../config/image.properties"

docker run -it --entrypoint ./versions.sh "${CONFIG[name]}:${CONFIG[version]}"
