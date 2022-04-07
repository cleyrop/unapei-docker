#!/bin/bash
_PWD=$(pwd)
_DIR=$(dirname "${0}")

#shellcheck source=functions/config.sh
source "${_DIR}/functions/config.sh"
read_config "${_DIR}/../config/image.properties"

echo -e "\n********************************************************************************"
echo -e "\tRUN Docker image ${CONFIG[name]}:${CONFIG[version]} !"
echo -e "********************************************************************************\n\n"

docker run -it --rm \
        --name ${CONFIG[container]} \
        -e DRUPAL_DATABASE_HOST \
        -e DRUPAL_DATABASE_PORT_NUMBER \
        -e DRUPAL_DATABASE_NAME \
        -e DRUPAL_DATABASE_USER \
        -e DRUPAL_DATABASE_PASSWORD \
        -e DRUPAL_SITE_URL_LABEL \
        -e DRUPAL_TRUSTED_HOST_PATTERN \
        -u www-data \
        -p 127.0.0.1:8080:8080/tcp \
        "${CONFIG[name]}:${CONFIG[version]}"
