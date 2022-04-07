#!/bin/bash

_DIR=$(dirname "${0}")

#shellcheck source=functions/config.sh
source "${_DIR}/functions/config.sh"
read_config "${_DIR}/../config/image.properties"

echo -e "\n********************************************************************************"
echo -e "\tCheck Docker image ${CONFIG[name]}:${CONFIG[version]} !"
echo -e "********************************************************************************\n\n"

if ! command -v container-structure-test &> /dev/null
then
    curl -LO https://storage.googleapis.com/container-structure-test/latest/container-structure-test-linux-amd64 && chmod +x container-structure-test-linux-amd64 && mkdir -p ${HOME}/bin && export PATH=${PATH}:${HOME}/bin && mv container-structure-test-linux-amd64 ${HOME}/bin/container-structure-test
fi
container-structure-test test \
    --driver docker \
    --image "${CONFIG[name]}:${CONFIG[version]}" \
    --config "${_DIR}/../docker/misc/test_image.yaml"
