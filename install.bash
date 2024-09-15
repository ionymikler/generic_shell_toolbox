#!/bin/bash
# Created by: Jonathan Mikler
# Creation Date: 29/February/24

SCRIPT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source "${SCRIPT_PATH}/shell_utils/colored_shell.sh"

source "${SCRIPT_PATH}/.make_env_file.sh"

function set_PS1(){
    local default_PS1="\[\e[38;5;47m\]\u\[\e[38;5;156m\]@\[\e[38;5;227m\]\h \[\e[38;5;231m\]\w \[\033[0m\]$ "
    echo "export PS1='$default_PS1'" >> "$SCRIPT_PATH/.env"
    echo "The default PS1 has been added to the .env file."
}

function add_to_bashrc(){
    local _sourcing_file_path="$HOME/.bashrc"
    echo "source ${GENERIC_SHELL_TOOLBOX_LOCATION}/generic_shell_toolbox.sh" >> $_sourcing_file_path

    # remember in env file
    echo "SOURCING_FILE_PATH=$_sourcing_file_path" >> "$SCRIPT_PATH/.env"

    log_info_green "The 'generic_shell_toolbox.sh' has been added to your bashrc file. Open a new terminal to see the changes."
}

install_gst(){
    local SET_DEFAULT_CONFIG='false'

    log_debug "$@"
    if [[ "$@" == *"-D"* ]]; then
        SET_DEFAULT_CONFIG=true
    fi
    log_debug "SET_DEFAULT_CONFIG: $SET_DEFAULT_CONFIG"

    # read version from dir_path/version.yaml
    local _version=$(cat "${SCRIPT_PATH}/version.yaml")
    log_info_blue "Installing the 'generic_shell_toolbox' $_version... \n"

    make_env_file

    # decide if including a default PS1 configuration
    local include_PS1="n"
    
    if [ "$SET_DEFAULT_CONFIG" == "true" ]; then
        include_PS1="y"
    else
        read -p "* Do you want to include a default PS1 configuration? (y/n): " include_PS1
    fi
    if [ "$include_PS1" == "y" ]; then
        set_PS1
    fi

    # decide if adding the 'generic_shell_toolbox.sh' to the bashrc file
    local paste_to_bashrc="n"
    
    if [ "$SET_DEFAULT_CONFIG" == "true" ]; then
        paste_to_bashrc="y"
    else
        read -p "* Do you want to add the 'generic_shell_toolbox.sh' to your bashrc file? (y/n): " paste_to_bashrc
    fi

    if [ "$paste_to_bashrc" == "y" ]; then
        add_to_bashrc
    fi

    log_info_green "Installation complete"

}

install_gst "$@"

