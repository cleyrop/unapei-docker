#!/bin/bash
_PWD=$(pwd)
_DIR=$(dirname "${0}")

#shellcheck source=functions/check.sh
source "${_DIR}/functions/check.sh"
#shellcheck source=functions/config.sh
source "${_DIR}/functions/config.sh"
read_config "${_DIR}/../config/image.properties"

# Create network for docker if doesn't exists
#check "docker network ls | grep capfalc" "docker network create capfalc"
#docker network ls 

# Launch MariaDB if doesn't exists 
#check "docker ps | grep mariadb" " \
#    docker run -d --rm \
#        --network capfalc \
#        --name mariadb \
#        --stop-signal SIGTERM \
#        -v "${_PWD}/../unapei-conf/db_unapei_250322.sql:/tmp/db.sql" \
#        -p 127.0.0.1:3306:3306/tcp \
#        -e MARIADB_USER=ypetit \
#        -e MARIADB_PASSWORD=Mcas2021 \
#        -e MARIADB_ROOT_PASSWORD=Mcas2022! \
#        mariadb:10"

# populate SQL content if necessary
#docker network inspect capfalc

docker run -it --rm \
        --name codatalab \
        --network capfalc \
        --stop-signal SIGTERM \
        -u www-data \
        -p 127.0.0.1:8080:80/tcp \
        -v "${_PWD}/../unapei-web:/var/www" \
        "${CONFIG[name]}:${CONFIG[version]}"
