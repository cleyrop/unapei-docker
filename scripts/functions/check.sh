#!/bin/bash

function check() {    
    if [ $# -ne 2 ]
    then
        echo "Usage: $0 <check command> <command to execute>"
        exit 1;
    fi;
    echo -en "\t\tTesting [${1}]"
    RESULT=$(eval "${1}")
    if [ ! $? -eq 0 ]; then
        eval $2
    else 
        echo -e "\t\033[32m ✔ OK\033[0m"
    fi
}

function checkUser() {
    check "getent passwd $1" "sudo -p "" -S bash -c 'useradd -u 33 www-data' <<< $PASS"
}

function checkGroup() {
    check "getent group $1" "sudo -p "" -S bash -c 'groupadd -g 33 www-data' <<< $PASS"
}

function checkMemberOfWWW() {
    check "groups | grep $2" "sudo -p "" -S bash -c 'usermod -a -G $2 $1' <<< $PASS"
}
