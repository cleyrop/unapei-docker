#!/bin/bash
_BRANCH="${2}"
_DIR=$(dirname "${0}")

if [[ ! -z ${_BRANCH+x} ]]; then
    sed -i 's/^version=.*$/version='${_BRANCH}'/g' ../config/image.properties
fi

#shellcheck source=functions/config.sh
source "${_DIR}/functions/config.sh"
read_config "${_DIR}/../config/image.properties"

echo -e "\n********************************************************************************"
echo -e "\tDeploy docker image ${CONFIG[name]}:${CONFIG[version]} !"
echo -e "********************************************************************************\n\n"

if [[ "manual" = "${1}" ]]; then
    docker logout
    read -s -p "Enter dockerhub password for Cleyrop :" PASS 
    docker login -u cleyrop -p "${PASS}"
fi

docker push "${CONFIG[name]}:${CONFIG[version]}"
