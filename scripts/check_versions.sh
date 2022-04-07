#!/bin/bash

_DIR=$(dirname "${0}")

#shellcheck source=functions/config.sh
source "${_DIR}/functions/config.sh"
read_config "${_DIR}/../config/image.properties"

echo -e "\n********************************************************************************"
echo -e "\tDisplay versions ${CONFIG[name]}:${CONFIG[version]} !"
echo -e "********************************************************************************\n\n"

docker run -it --entrypoint versions.sh "${CONFIG[name]}:${CONFIG[version]}"
