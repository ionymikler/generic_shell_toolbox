
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

main(){
    verify_env_file

    # source utils
    source "${GENERIC_SHELL_TOOLBOX_LOCATION}/shell_utils/utils_source.sh"

    # source addons
    source "${GENERIC_SHELL_TOOLBOX_LOCATION}/shell_addons/addons_source.sh"
}

main
