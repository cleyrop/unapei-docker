#!/bin/bash

_DIR=$(dirname "${0}")
#shellcheck source=functions/config.sh
source "${_DIR}/functions/config.sh"
read_config "${_DIR}/../config/image.properties"

#docker run -it --rm --name capfalc "${CONFIG[name]}":"${CONFIG[version]}"
#docker run -it --rm --name capfalc --entrypoint bash "${CONFIG[name]}":"${CONFIG[version]}"
docker run -it --rm \
        --network capfalc-network \
        --name codatalab \
        -p 127.0.0.1:80:80/tcp \
        -v "/home/finalspy/linux-Codata/unapei/web:/var/www/html" \
        -v "/home/finalspy/linux-Codata/unapei/conf/settings.php:/var/www/html/sites/default/settings.php" \
        -v "/home/finalspy/linux-Codata/unapei/conf/settings.local.php:/var/www/html/sites/default/settings.local.php" \
        "${CONFIG[name]}:${CONFIG[version]}"

#        -v "/home/finalspy/linux-Codata/unapei/conf/sites.php:/var/www/html/sites/sites.php" \

