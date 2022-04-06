#!/bin/bash
_PWD=$(pwd)
_DIR=$(dirname "${0}")

#shellcheck source=functions/config.sh
source "${_DIR}/functions/config.sh"
read_config "${_DIR}/../config/image.properties"

echo -e "\n***************************************"
echo -e "\tRUN Docker image CapFalc !"
echo -e "***************************************\n\n"

docker run -it --rm \
        --name codatalab \
        -e DRUPAL_DATABASE_HOST \
        -e DRUPAL_DATABASE_PORT_NUMBER \
        -e DRUPAL_DATABASE_NAME \
        -e DRUPAL_DATABASE_USER \
        -e DRUPAL_DATABASE_PASSWORD \
        -e DRUPAL_SITE_URL_LABEL \
        -u www-data \
        -p 127.0.0.1:8080:80/tcp \
        "${CONFIG[name]}:${CONFIG[version]}"
