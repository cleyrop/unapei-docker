#!/bin/bash
echo -e "\n[PHP]"
php -v

echo -e "\n[DRUPAL]"
cat /opt/drupal/web/core/lib/Drupal.php | grep "const VERSION"

echo -e "\n[XML Extension]"
php --ri xml | grep -i xml

echo -e "\n[GD Extension]"
php --ri gd | grep -i gd

echo -e "\n[OpenSSL +  Extension]"
openssl version
echo '<?php phpinfo(); ?>' | php 2>&1 | grep -vi command | grep -i ssl

echo -e "\n[JSON Extension]"
php --ri json | grep -i support

echo -e "\n[cURL + Extension]"
curl --version
php --ri curl | grep -i curl

echo -e "\n[mbString Extension]"
php --ri mbstring

echo -e "\n[ssh2]"
php --ri ssh2

echo -e "\nList PHP Modules compiled :"
php -m

echo -e "\nList PHP Modules installed :"
dpkg --get-selections | grep -i php

