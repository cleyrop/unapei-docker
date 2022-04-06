#!/bin/bash
_PWD=$(pwd)
_DIR=$(dirname "${0}")

#shellcheck source=functions/config.sh
source "${_DIR}/functions/config.sh"
read_config "${_DIR}/../config/image.properties"

docker exec -it -u root codatalab bash 
