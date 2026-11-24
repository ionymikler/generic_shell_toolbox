
function _gst_verify_env_file(){
    # checks if '.env' file exists, is so source it, if not echo an error message

    local script_dir
    script_dir=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
    if [ -f "${script_dir}/.env" ]; then
        source "${script_dir}/.env"
        
    else
        echo "Error .env '${script_dir}/.env' file does not exist."
        return 1
    fi
}

function _gst_source_core(){
    source "${GENERIC_SHELL_TOOLBOX_LOCATION}/shell_utils/colored_shell.sh"
    source "${GENERIC_SHELL_TOOLBOX_LOCATION}/enabling.sh"
}


function _gst_source_toolbox(){
    source "${GENERIC_SHELL_TOOLBOX_LOCATION}/shell_utils/utils_source.sh"
    source "${GENERIC_SHELL_TOOLBOX_LOCATION}/shell_addons/addons_source.sh"
}

function _gst_source_extensions(){
    source "${GENERIC_SHELL_TOOLBOX_LOCATION}/.extensions/extensions_source.sh"
}

_gst_main(){
    # select command between 'activate' and 'deactivate'
    _gst_verify_env_file
    _gst_source_core

    # if TOOLBOX_ENABLED is set to 'true' source the rest of the toolbox
    if [ "${TOOLBOX_ENABLED}" == "true" ]; then
        _gst_source_toolbox
        _gst_source_extensions
        local version=$(gst_version | grep "version:" | cut -d' ' -f2)
        log_info "[GST] ToolBox (${version}) enabled"
    fi

}

_gst_main # Issue #5
unset -f _gst_main _gst_verify_env_file _gst_source_core _gst_source_toolbox _gst_source_extensions
