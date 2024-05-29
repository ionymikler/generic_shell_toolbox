#!/usr/bin/env bash
# Created by Jonathan Mikler on 29/February/24

# this script is used to define aliases
function gst_version(){
    # echo version from file ${GENERIC_SHELL_TOOLBOX_LOCATION}/version.yaml
    local version_file="${GENERIC_SHELL_TOOLBOX_LOCATION}/version.yaml"
    if [ -f "$version_file" ]; then
        cat "$version_file"
    else
        log_error "No version file found."
    fi
}


function rebash(){
    log_info 'resourcing ~/.bashrc'
    source "~/.bashrc"
}