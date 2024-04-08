#!/usr/bin/env bash
# Created by Jonathan Mikler on 29/February/24

# This script is used to configure the PS1

main(){
    source "${GENERIC_SHELL_TOOLBOX_LOCATION}/shell_addons/git_utils.sh"

    # Edit of the bash entrypoint: (bashrcgenerator.com/)
    export PS1="$PS1\[\033[01;31m\]\$(get_repository_name):\$(parse_git_branch)\[\033[00m\] \n> "

}

main


