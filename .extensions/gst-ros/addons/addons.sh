#!/usr/bin/env bash
# Created by Jonathan Mikler on 03/July/24

# TODO: Describe the purpise of this file
# Wrapped in a function so nothing leaks into the user's shell.
_gst_ros_load_addons(){
    source "${GENERIC_SHELL_TOOLBOX_LOCATION}/.extensions/gst-ros/addons/rcutils_config.sh"
}

_gst_ros_load_addons
unset -f _gst_ros_load_addons
