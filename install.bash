#!/bin/bash
# Created by: Jonathan Mikler
# Creation Date: 29/February/24

SCRIPT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source "${SCRIPT_PATH}/shell_utils/colored_shell.sh"

function set_PS1(){
    # decide if including a default PS1 configuration
    read -p "Do you want to include a default PS1 configuration? (y/n): " include_PS1

    if [ "$include_PS1" == "y" ]; then
        local default_PS1="\[\e[38;5;47m\]\u\[\e[38;5;156m\]@\[\e[38;5;227m\]\h \[\e[38;5;231m\]\w \[\033[0m\]$ "
        echo "export PS1='$default_PS1'" >> "$script_dir/.env"
        echo "The default PS1 has been added to the .env file."
    fi
    echo ""
}

function add_to_bashrc(){
    read -p "Do you want to add the 'generic_shell_toolbox.sh' to your bashrc file? (y/n): " paste_to_bashrc

    if [ "$paste_to_bashrc" == "y" ]; then
        echo "source ${GENERIC_SHELL_TOOLBOX_LOCATION}/generic_shell_toolbox.sh" >> ~/.bashrc
        echo "The 'generic_shell_toolbox.sh' has been added to your bashrc file. Open a new terminal to see the changes."
    fi
    printf "Installation complete.\n"
}

main(){
    log_info_blue "Installing the 'generic_shell_toolbox'... \n"

    bash .make_env_file.sh

    set_PS1
    add_to_bashrc

    printf "Installation complete.\n"

}

main

