#!/usr/bin/env bash
# Created by Jonathan Mikler on 29/February/24

# This script is used to configure the PS1



main(){
    source "${GENERIC_SHELL_TOOLBOX_LOCATION}/shell_addons/git_utils.sh"

    gst_load_ps1_scheme "${GST_PS1_COLOR_SCHEME:-dark_default}"

    export PS1="${GST_PS1_C_USER}\u${GST_PS1_C_AT}@${GST_PS1_C_HOST}\h ${GST_PS1_C_CWD}\w ${GST_PS1_C_RESET}\$ ${GST_PS1_C_GIT_REPO}(\$(get_repository_name):${GST_PS1_C_GIT_BRANCH}\$(parse_git_branch))${GST_PS1_C_RESET} \n> "
}

main


