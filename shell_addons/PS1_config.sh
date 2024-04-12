#!/usr/bin/env bash
# Created by Jonathan Mikler on 29/February/24

# This script is used to configure the PS1



main(){

    local RED='\033[01;31m'
    local DARK_RED='\033[00;31m'
    local GREEN='\033[01;32m'
    local DARK_GREEN='\033[00;32m'
    local YELLOW='\033[01;33m'
    local BLUE='\033[01;34m'
    local NO_COLOR='\033[00m'

    source "${GENERIC_SHELL_TOOLBOX_LOCATION}/shell_addons/git_utils.sh"


    local GIT_BRANCH_COLOR="${RED}"
    local GIT_REPO_COLOR="${DARK_RED}"

    export PS1="$PS1${GIT_REPO_COLOR}(\$(get_repository_name):${GIT_BRANCH_COLOR}$(parse_git_branch))${NO_COLOR} \n> "

}

main


