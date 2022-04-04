#!/bin/bash

_PWD=$(pwd)
_DIR=$(dirname "${0}")

#shellcheck source=functions/check.sh
source "${_DIR}/functions/check.sh"

# Read passwd for sudo when necessary
echo -n "Please enter the password for sudo commands : "
read -s PASS
echo 

#TODO check if sudo password is correct else display error and exit 

echo -e "\n***************************************"
echo -e "\tInstall CapFalc !"
echo -e "***************************************\n\n"

### TODO check current tools
# prerequisite :
# - TODO git
# - TODO docker

### check current user 
echo -e "\n\ttest if www-data (33) user/group exists and if curent user is memberOf"
checkUser 33
checkGroup 33
checkMemberOfWWW $(whoami) www-data

### check sources & conf
echo -e "\n\tcheckout latest web"
if [ ! -d "${_PWD}/../unapei.orig" ]; then
    git clone git@github.com:subskill/unapei.git "${_PWD}/../unapei.orig"
fi
echo -e "\n\tcheck branch"
#in some case index is lost so force rebuild then check branch to change if necessary then pull
cd "${_PWD}/../unapei.orig" \
    && rm -f .git/index \
    && git reset \
    && check "git rev-parse --abbrev-ref HEAD | grep develop" "git switch develop" \
    && git pull -q
echo -e "\n\tcopy to shared folder"
sudo -p "" -S bash -c "rm -rf \"${_PWD}/../unapei-web\"" <<< ${PASS}
mkdir -p "${_PWD}/../unapei-web"
sudo -p "" -S bash -c "cp -f ./composer.lock  \"${_PWD}/../unapei-web\"" <<< ${PASS}
sudo -p "" -S bash -c "cp -f ./composer.lock  \"${_PWD}/docker/resources/composer.lock\"" <<< ${PASS}
sudo -p "" -S bash -c "cp -f ./composer.json \"${_PWD}/../unapei-web\"" <<< ${PASS}
sudo -p "" -S bash -c "cp -f ./composer.json \"${_PWD}/docker/resources/composer.json\"" <<< ${PASS}
sudo -p "" -S bash -c "cp -rf ./web \"${_PWD}/../unapei-web\"" <<< ${PASS}
sudo -p "" -S bash -c "chown -R www-data:www-data \"${_PWD}/../unapei-web\"" <<< ${PASS}
sudo -p "" -S bash -c "chmod -R g=u \"${_PWD}/../unapei-web\"" <<< ${PASS}

#rm -rf "${_PWD}/../unapei-web/web/sites/default.orig"
#mv "${_PWD}/../unapei-web/web/sites/default" "${_PWD}/../unapei-web/web/sites/default.orig"     
#mv "${_PWD}/../unapei-web/web/sites/unapei.fr" "${_PWD}/../unapei-web/web/sites/default"
#sed -i 's:sites/unapei.fr/:sites/default/:g' *
#cd "${_PWD}/../unapei-web/web/sites/default" || exit
#find . -type f -name "*" -print0 | xargs -0 sed -i 's:sites/unapei.fr/:sites/default/:g'
cd "${_PWD}" || exit


if [ ! -d "${_PWD}/../unapei-conf" ] || \
    [ ! -f "${_PWD}/../unapei-conf/settings.php" ] || \
    [ ! -f "${_PWD}/../unapei-conf/settings.local.php" ] || \
    [ ! -f "${_PWD}/../unapei-conf/services.yml" ] || \
    [ ! -f "${_PWD}/../unapei-conf/development.services.yml" ] || \
    [ ! -f "${_PWD}/../unapei-conf/sites.php" ]; then 
    echo "Some conf files are missing !"
else
    cd "${_PWD}/../unapei-conf/" || exit

    cp "${_PWD}/../unapei-conf/settings.php" "${_PWD}/../unapei-web/web/sites/unapei.fr/settings.php"
    cp "${_PWD}/../unapei-conf/settings.local.php" "${_PWD}/../unapei-web/web/sites/unapei.fr/settings.local.php"

    cp "${_PWD}/../unapei-conf/services.yml" "${_PWD}/../unapei-web/web/sites/unapei.fr/services.yml"
    cp "${_PWD}/../unapei-conf/development.services.yml" "${_PWD}/../unapei-web/web/sites/unapei.fr/development.services.yml"

    cp "${_PWD}/../unapei-conf/sites.php" "${_PWD}/../unapei-web/web/sites/sites.php"
    
    cd "${_PWD}/../unapei-web/" || exit
    sudo -p "" -S bash -c "chown -R www-data:www-data ." <<< ${PASS}
    #sudo -p "" -S bash -c "chmod u+w -R ." <<< ${PASS}
    #sudo -p "" -S bash -c "chmod g=u -R ." <<< ${PASS}
fi
### check conf

#find . -type f -name "*" -print0 | xargs -0 sed -i 's:sites/unapei.fr/:sites/default/:g'

#echo -e "\n\tCONF DIR"
#ls -al "${_PWD}/../unapei-conf/"
#echo -e "\n\tSETTINGS"
#cat "${_PWD}/../unapei-conf/settings.php"
#echo -e "\n\tLOCAL"
#cat "${_PWD}/../unapei-conf/settings.local.php"
#echo -e "\n\tSITES"
#cat "${_PWD}/../unapei-conf/sites.php"
#
#echo -e "\n\tWEB DIR"
#ls -al "${_PWD}/../unapei-web/"

#sudo chown www-data:www-data ${_PWD}/../unapei-conf/settings.php
#sudo chown www-data:www-data ${_PWD}/../unapei-conf/settings.local.php

#sudo chown -R www-data:www-data ${_PWD}/../unapei.orig
#sudo chown -R www-data:www-data ${_PWD}/../unapei

cd "${_PWD}" || exit
