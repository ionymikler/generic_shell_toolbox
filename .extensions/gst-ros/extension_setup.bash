#!/usr/bin/env bash
# Created by Jonathan Mikler on 27/June/24

SCRIPT_DIR="$(dirname "${BASH_SOURCE[0]}")"
SCRIPT_DIR=$(realpath "$SCRIPT_DIR" )

function source_extension_config(){
    source "${SCRIPT_DIR}/extension.config"
}

function source_utils(){
    source "${SCRIPT_DIR}/utils/utils.sh"
}

function source_addons(){
    source "${SCRIPT_DIR}/addons/addons.sh"
}

main(){
    source_utils
    source_extension_config
    source_addons
}

main