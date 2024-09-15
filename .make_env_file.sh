#!/usr/bin/env bash
# Created by Jonathan Mikler on 29/February/24

# INFO: gets the absolute path of the 'generic_shell_toolbox' directory and writes it to a .env file inside of it
_script_dir=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
_env_file_default_content="# This file was automatically generated at install-time.
DO NOT OVERWRITE!
export GENERIC_SHELL_TOOLBOX_LOCATION=$_script_dir
export TOOLBOX_ENABLED=true
"

function make_env_file(){
    local replace_env='n'
    
    if [[ "$@" == *"-y"* ]]; then
        replace_env='y'
    fi

    printf "Creating the .env file... \n"

    if [ -f "$_script_dir/.env" ]; then
        source "$_script_dir/.env"
        log_warn "file .env already exists in $_script_dir/.env"

        if [["$replace_env" == "n"]]; then
            read -p "* Replace existing env file '${_script_dir}'? (y/n): " replace_env
        fi

        if [ "$replace_env" == "y" ]; then
            echo "$_env_file_default_content" > "$_script_dir/.env"
            source "$_script_dir/.env"
            echo "The .env file has been replaced."
        fi
    else
        echo "$_env_file_default_content" > "$_script_dir/.env"
        source "$_script_dir/.env"
        echo "The .env file has been updated."
    fi
    echo ""

}