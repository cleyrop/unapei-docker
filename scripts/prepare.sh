#!/bin/bash
_PWD=$(pwd)
_DIR=$(dirname "${0}")
_BRANCH="${1}"

#shellcheck source=functions/config.sh
source "${_DIR}/functions/config.sh"
read_config "${_DIR}/../config/image.properties"

#shellcheck source=functions/check.sh
source "${_DIR}/functions/check.sh"

echo -e "\n********************************************************************************"
echo -e "\tPREPARE ${CONFIG[name]}:${CONFIG[version]} !"
echo -e "********************************************************************************\n\n"

# Check tools are installed
check "git --version" "exit"
check "docker --version" "exit"

TARGET_WWW="${_PWD}/../docker/resources/www"

echo -e "\n *\tCheckout ${_BRANCH} from web"
rm -rf "${TARGET_WWW}"
git clone --quiet --depth 1 -b "${_BRANCH}" git@github.com:cleyrop/unapei.git "${TARGET_WWW}"
rm -rf "${TARGET_WWW}"/.git*

if [[ "copyFiles" = "${2}" ]]; then
    echo -e "\n *\tCopy external files "
    cd "${_PWD}/../../unapei-files/" || exit
    cp -rf files "${TARGET_WWW}"/web/sites/unapei.fr/
    cd "${_PWD}" || exit
fi
