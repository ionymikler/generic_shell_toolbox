#!/usr/bin/env bash
# Created by Jonathan Mikler on 29/May/24


SCRIPT_DIR="$(dirname "${BASH_SOURCE[0]}")"
source "${SCRIPT_DIR}/utils_source.sh"

function delete_text_from_file(){
    local _text=$1
    local _file_path=$2 # file to delete text from, full path

    # Escape any forward slashes in the _text variable
    local escaped_text=$(echo "$_text" | sed 's/[\/&]/\\&/g')

    # delete the text from the file
    log_info "Deleting line containing: '${_text}' from file: ${_file_path}"
    sed -i "/${escaped_text}/d" "${_file_path}"
}

function gst_uninstall(){
    # 1 delete line containig '.../generic_shell_toolbox/generic_shell_toolbox.sh' from the given file
    # 2 Ask wether to delete the generic_shell_toolbox folder
    # 3 If yes, delete the folder

    # source env file
    if [ -z "${GENERIC_SHELL_TOOLBOX_LOCATION}/.env" ]; then
        echo "Error: ${GENERIC_SHELL_TOOLBOX_LOCATION}/.env file not provided"
        return 1
    else
        source "${GENERIC_SHELL_TOOLBOX_LOCATION}/.env"
        _local_env_file="${GENERIC_SHELL_TOOLBOX_LOCATION}/.env"
    fi

    # vals from env
    local _toolbox_location=$GENERIC_SHELL_TOOLBOX_LOCATION
    local _sourcing_file_path=$SOURCING_FILE_PATH

    # delete from the line containing the toolbox location from the file
    delete_text_from_file "generic_shell_toolbox/generic_shell_toolbox.sh" "${_sourcing_file_path}"


    log_debug "Toolbox location: ${_toolbox_location}"
    # ask wether to delete the toolbox folder
    read -p "Do you want to delete the toolbox folder? [y/n]: " _delete_folder
    if [ "${_delete_folder}" == "y" ]; then
        log_info "Deleting the toolbox folder: ${_toolbox_location}"
        rm -rf "${_toolbox_location}"
        log_info "Toolbox folder deleted"
    fi

}