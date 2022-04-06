#!/bin/bash
_PWD=$(pwd)
_DIR=$(dirname "${0}")

#shellcheck source=functions/check.sh
source "${_DIR}/functions/check.sh"

echo -e "\n***************************************"
echo -e "\tPREPARE CapFalc !"
echo -e "***************************************\n"

### TODO check current tools
# prerequisite :
# - TODO git
# - TODO docker

TARGET_WWW="${_PWD}/docker/resources/www"

echo -e "\n *\tCheckout latest web"
rm -rf "${TARGET_WWW}"
git clone --quiet --depth 1 -b develop git@github.com:cleyrop/unapei.git "${TARGET_WWW}"

echo -e "\n *\tCopy external files "
cd "${_PWD}/../unapei-files/" || exit
cp -rf files "${TARGET_WWW}/web/sites/unapei.fr/"
cd "${_PWD}" || exit
