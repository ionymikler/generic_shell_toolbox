#!/usr/bin/env bash
# Created by Jonathan Mikler on 27/June/24

# Wrapped in a function so the path stays local and nothing leaks into the user's shell.
_gst_ros_setup(){
    local dir
    dir=$(realpath "$(dirname "${BASH_SOURCE[0]}")")
    source "${dir}/utils/utils.sh"
    source "${dir}/extension.config"
    source "${dir}/addons/addons.sh"
}

_gst_ros_setup
unset -f _gst_ros_setup
