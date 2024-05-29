#!/usr/bin/env bash
# Created by Jonathan Mikler on 29/February/24

# this script is used to define aliases

_env="$GENERIC_SHELL_TOOLBOX_LOCATION/.env"
function gst_enable(){
    echo "Enabling Generic-ToolBox"

    # script dir is the first argument passed to the function

    if [ -f "$_env" ]; then
        # if the .env file exists, check if the TOOLBOX_ENABLED variable exists, if so, overwrite it to 'true'
        # If it does not exists, create it and set it to 'true'

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

    # reload terminal
    source ~/.bashrc

}

function gst_disable(){
    echo "Disabling Generic-ToolBox"
    _env="$GENERIC_SHELL_TOOLBOX_LOCATION/.env"
    if [ -f "$_env" ]; then
        sed -i 's/TOOLBOX_ENABLED=.*/TOOLBOX_ENABLED=false/' "$_env"
    else
        log_error "Error '$_env' file does not exist."
        return 1
    fi

    # reload terminal
    source ~/.bashrc
}

# function run_command(){
#     local _env=$1
#     _commands=(
#         "enable"
#         "disable"
#     )
#     case $2 in
#         "enable")
#             enable_toolbox
#             ;;
#         "disable")
#             echo "Disabling Generic-ToolBox"
#             sed -i 's/TOOLBOX_ENABLED=.*/TOOLBOX_ENABLED=false/' $_env
#             ;;
#         *)
#             echo "Error: command not found"
#             echo "Available commands: ${_commands[@]}"
#             ;;
#     esac
# }