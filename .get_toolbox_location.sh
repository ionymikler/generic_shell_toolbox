#!/usr/bin/env bash
# Created by Jonathan Mikler on 29/February/24

# get the absolute path of the 'generic_shell_toolbox' directory and wirtes it on a .env file inside of it

main(){
    script_dir=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
    echo "Toolbox location: $script_dir"
    echo "export GENERIC_SHELL_TOOLBOX_LOCATION=$script_dir" > $script_dir/.env

}

main