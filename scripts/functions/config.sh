#!/bin/bash

declare -A CONFIG

function read_config() {
    IFS="="
    while read -r _KEY _VAL
    do
        if [ -n "${_VAL}" ]; then
            CONFIG[${_KEY}]="${_VAL}"
        else
            CONFIG[${_KEY}]=""
        fi
    done < "${1}"
    unset IFS
}

function get_config() {
    if [ "${1}" ]; then
        if [ -n "${CONFIG[${1}]}" ]; then
            echo "Key: ${1}, Value: ${CONFIG[$1]}"
        else
            echo "The key '${1}' does not exist"
        fi
    else
        for K in "${!CONFIG[@]}"; do
            if [ -n "${CONFIG[${K}]}" ]; then
                echo "Key: ${K}, Value: ${CONFIG[${K}]}"
            else
                echo "Key: ${K} has no value"
            fi
        done
    fi
}
