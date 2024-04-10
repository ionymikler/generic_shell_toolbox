#!/bin/bash
# Created by: Jonathan Mikler
# Creation Date: 29/February/24


main(){
    bash .make_env_file.sh
    # if [ -f "./.env" ]; then
    #     source "./.env"
    #     echo "source ${GENERIC_SHELL_TOOLBOX_LOCATION}/generic_shell_toolbox.sh" >> ~/.bashrc
    # fi

    # source ~/.bashrc

    echo "Installation complete. remember to add the 'generic_shell_toolbox.sh' to your bashrc file."
}

main

