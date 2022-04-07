#!/bin/bash

_DIR=$(dirname "${0}")

#shellcheck source=functions/config.sh
source "${_DIR}/functions/config.sh"
read_config "${_DIR}/../config/image.properties"

echo -e "\n********************************************************************************"
echo -e "\tDeploy docker image ${CONFIG[name]}:${CONFIG[version]} !"
echo -e "********************************************************************************\n\n"

docker logout
read -s -p "Enter dockerhub password for Cleyrop :" PASS 
docker login -u cleyrop -p "${PASS}"
docker push "${CONFIG[name]}:${CONFIG[version]}"
