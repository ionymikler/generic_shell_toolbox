#!/usr/bin/env bash
# Created by Jonathan Mikler on 29/February/24

# INFO: gets the absolute path of the 'generic_shell_toolbox' directory and writes it to a .env file inside of it

_script_dir=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
_env_file_default_content="# This file is used to store environment variables for the 'generic_shell_toolbox' tool.
export GENERIC_SHELL_TOOLBOX_LOCATION=$_script_dir
export TOOLBOX_ENABLED=true
"

function make_env_file(){
    printf "Creating the .env file... \n"

    if [ -f "$script_dir/.env" ]; then
        source "$script_dir/.env"
        echo "file .env already exists in $script_dir/.env"
        read -p "Replace existing env file '${script_dir}'? (y/n): " replace_env

        if [ "$replace_env" == "y" ]; then
            echo "$_env_file_default_content" > "$script_dir/.env"
            source "$script_dir/.env"
            echo "The .env file has been replaced."
        fi
    else
        echo "$_env_file_default_content" > "$script_dir/.env"
        source "$script_dir/.env"
        echo "The .env file has been updated."
    fi
    echo ""

}