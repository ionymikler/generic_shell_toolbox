#!/usr/bin/env bash
# Created by Jonathan Mikler on 29/February/24

# This script is used to configure the PS1



_gst_configure_PS1(){

    local RED='\033[01;31m'
    local DARK_RED='\033[00;31m'
    local GREEN='\033[01;32m'
    local DARK_GREEN='\033[00;32m'
    local YELLOW='\033[01;33m'
    local DARK_YELLOW='\033[00;33m'
    local BLUE='\033[01;34m'
    local NO_COLOR='\033[00m'

    source "${GENERIC_SHELL_TOOLBOX_LOCATION}/shell_addons/git_utils.sh"


    local GIT_BRANCH_COLOR="${RED}"
    local GIT_REPO_COLOR="${DARK_RED}"
    local GIT_COMMIT_COLOR="${DARK_YELLOW}"

    # Colour codes are wrapped in \[ \] so bash does not count them as visible
    # characters; otherwise long command lines wrap and redraw incorrectly.
    export PS1="$PS1\[${GIT_REPO_COLOR}\](\$(get_repository_name):\[${GIT_BRANCH_COLOR}\]\$(parse_git_branch)\[${GIT_COMMIT_COLOR}\]\$(get_last_commit_suffix)\[${GIT_BRANCH_COLOR}\])\[${NO_COLOR}\] \n> "

}

_gst_configure_PS1
unset -f _gst_configure_PS1


