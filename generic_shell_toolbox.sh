
function verify_env_file(){
    # checks if '.env' file exists, is so source it, if not echo an error message

    script_dir=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
    if [ -f "${script_dir}/.env" ]; then
        source "${script_dir}/.env"
    else
        echo "Error .env '${script_dir}/.env' file does not exist, please run the '.get_toolbox_location.sh' script"
        return 1
    fi
}

function enable_toolbox(){
    # script dir is the first argument passed to the function
    local _script_dir=$1

    if [ -f "${_script_dir}/.env" ]; then
        # if the .env file exists, check if the TOOLBOX_ENABLED variable exists, if so, overwrite it to 'true'
        # If it does not exists, create it and set it to 'true'
        source "${_script_dir}/.env"
        if [ -z "${TOOLBOX_ENABLED}" ]; then
            # echo "writing TOOLBOX_ENABLED=true to .env file"
            echo "TOOLBOX_ENABLED=true" >> "${_script_dir}/.env"
        else
            sed -i 's/TOOLBOX_ENABLED=.*/TOOLBOX_ENABLED=true/' "${_script_dir}/.env"
        fi
        echo "Generic-ToolBox enabled"
    else
        echo "Error .env '${_script_dir}/.env' file does not exist, please run the '.get_toolbox_location.sh' script"
        return 1
    fi

}

function source_core(){
    source "${GENERIC_SHELL_TOOLBOX_LOCATION}/shell_utils/colored_shell.sh"
    source "${GENERIC_SHELL_TOOLBOX_LOCATION}/enabling.sh"
}

function source_toolbox(){
    source "${GENERIC_SHELL_TOOLBOX_LOCATION}/shell_utils/utils_source.sh"
    source "${GENERIC_SHELL_TOOLBOX_LOCATION}/shell_addons/addons_source.sh"
}

gst_main(){
    # script_dir=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
    # enable_toolbox $script_dir

    # select command between 'activate' and 'deactivate'
    verify_env_file
    source_core

    # if TOOLBOX_ENABLED is set to 'true' source the rest of the toolbox
    if [ "${TOOLBOX_ENABLED}" == "true" ]; then
        source_toolbox
        log_info "Generic-Shell-ToolBox enabled"
    fi

}

gst_main # Issue #5
