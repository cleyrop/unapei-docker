#!/bin/bash
_PWD=$(pwd)
_DIR=$(dirname "${0}")

#shellcheck source=functions/check.sh
source "${_DIR}/functions/check.sh"
#shellcheck source=functions/config.sh
source "${_DIR}/functions/config.sh"
read_config "${_DIR}/../config/image.properties"

# Create network for docker if doesn't exists
check "docker network ls | grep capfalc" "docker network create capfalc"
#docker network ls 

# Launch MariaDB if doesn't exists 
check "docker ps | grep mariadb" " \
    docker run -d --rm \
        --network capfalc \
        --name mariadb \
        --stop-signal SIGTERM \
        -v "${_PWD}/../unapei-conf/db_unapei_250322.sql:/tmp/db.sql" \
        -p 127.0.0.1:3306:3306/tcp \
        -e MARIADB_USER=ypetit \
        -e MARIADB_PASSWORD=Mcas2021 \
        -e MARIADB_ROOT_PASSWORD=Mcas2022! \
        mariadb:10"

# TODO populate SQL content if necessary
#docker network inspect capfalc

#docker run -it --rm --name capfalc "${CONFIG[name]}":"${CONFIG[version]}"
#docker run -it --rm --name capfalc --entrypoint bash "${CONFIG[name]}":"${CONFIG[version]}"

docker run -it --rm \
        --network capfalc \
        --name codatalab \
        --stop-signal SIGTERM \
        -p 127.0.0.1:8080:80/tcp \
        -v "${_PWD}/../unapei-web/web:/var/www/web" \
        -v "${_PWD}/../unapei-conf/files:/var/www/web/sites/default/files" \
        -v "${_PWD}/../unapei-conf/services.yml:/var/www/web/sites/default/services.yml" \
        -v "${_PWD}/../unapei-conf/development.services.yml:/var/www/web/sites/default/development.services.yml" \
        -v "${_PWD}/../unapei-conf/settings.php:/var/www/web/sites/default/settings.php" \
        -v "${_PWD}/../unapei-conf/settings.local.php:/var/www/web/sites/default/settings.local.php" \
        -v "${_PWD}/../unapei-ssh/id_rsa:/var/www.ssh/id_rsa" \
        -v "${_PWD}/../unapei-ssh/id_rsa.pub:/var/www/.ssh/id_rsa.pub" \
        "${CONFIG[name]}:${CONFIG[version]}"

#        -v "/home/finalspy/linux-Codata/unapei/conf/sites.php:/var/www/web/sites/sites.php" \
