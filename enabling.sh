#!/usr/bin/env bash
# Created by Jonathan Mikler on 29/February/24

# this script is used to define aliases

function enable_toolbox(){
    # script dir is the first argument passed to the function
    local _env=$1

    if [ -f "$_env" ]; then
        # if the .env file exists, check if the TOOLBOX_ENABLED variable exists, if so, overwrite it to 'true'
        # If it does not exists, create it and set it to 'true'
        source "$_env"
        if [ -z "${TOOLBOX_ENABLED}" ]; then
            # echo "writing TOOLBOX_ENABLED=true to .env file"
            echo "TOOLBOX_ENABLED=true" >> "$_env"
        else
            sed -i 's/TOOLBOX_ENABLED=.*/TOOLBOX_ENABLED=true/' "$_env"
        fi
        echo "Generic-ToolBox enabled"
    else
        log_error "Error '$_env' file does not exist."
        return 1
    fi

}

function run_command(){
    local _env=$1
    _commands=(
        "enable"
        "disable"
    )
    case $2 in
        "enable")
            enable_toolbox $_env
            ;;
        "disable")
            echo "Disabling Generic-ToolBox"
            sed -i 's/TOOLBOX_ENABLED=.*/TOOLBOX_ENABLED=false/' $_env
            ;;
        *)
            echo "Error: command not found"
            echo "Available commands: ${_commands[@]}"
            ;;
    esac
}

main(){
    # source parent .env file
    _env="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")/.env"

alias sht="run_command $_env $1"
}

main
