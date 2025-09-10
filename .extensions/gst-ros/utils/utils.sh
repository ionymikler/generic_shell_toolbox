#!/usr/bin/env bash
# Created by Jonathan Mikler on 31/August/23
GST_ROS_CONF_FILE="$HOME/generic_shell_toolbox/.extensions/gst-ros/extension.config" #TODO: This is too hardocoded, and should not be here anyway

alias gzb_src="log_info 'sourcing gazebo'&&source /usr/share/gazebo/setup.sh"
alias rebash="source ~/.bashrc"

function rsrc() {
    if [[ $1 == "-g" || $1 == "--source-gazebo" ]]; then
        gzb_src
    fi
    # Source ROS setup file for the current workspace
    local parent_dir=${PWD##*/}
    local setup_file="$PWD/install/setup.bash"
    if [ -f "$setup_file" ]; then
        # get name of parent folder
        log_info "sourcing setup for ws '$parent_dir' ($setup_file)"
        source "$setup_file"
    else
        log_error "Error: $setup_file not found.
        Are you in a ROS workspace?
        Is the workspace built?"
    fi
}

function roslog_del() {
    ROSLOG_DIR="$HOME/.ros/log"
    log_info "cleaning ros log ($ROSLOG_DIR)"
    rm -rf "$ROSLOG_DIR"/*
}

function del_pkg(){
    local pkg_name=$1
    
    # Get current workspace (absolute path)
    local ws_dir
    ws_dir=$(gst_ros_get_ws)
    if [ $? -ne 0 ]; then
        return 1
    fi

    if [ -z "$pkg_name" ]; then
        log_error "A package name is required."
        return 1
    fi

    local build_dir="${ws_dir}/build/${pkg_name}"
    local install_dir="${ws_dir}/install/${pkg_name}"
    local log_dir="${ws_dir}/log/${pkg_name}"

    if [ -d "$build_dir" ]; then
        log_info "Deleting $build_dir"
        rm -rf "$build_dir"
    else
        log_warn "Build directory not found for $pkg_name"
    fi

    if [ -d "$install_dir" ]; then
        log_info "Deleting $install_dir"
        rm -rf "$install_dir"
    else
        log_warn "Install directory not found for $pkg_name"
    fi

    if [ -d "$log_dir" ]; then
        log_info "Deleting $log_dir"
        rm -rf "$log_dir"
    else
        log_warn "Log directory not found for $pkg_name"
    fi


}

function rospkg_del() {
    if [ -z "$GST_SELECTED_ROS_WS" ]; then
        log_error "No ROS ('GST_SELECTED_ROS_WS') workspace selected."
        return 1
    fi
    # Get current workspace (absolute path)
    local base_dir
    base_dir=$(gst_ros_get_ws)
    if [ $? -ne 0 ]; then
        return 1
    fi

    if [ $# -eq 0 ]; then
        log_error "At least one package name is required."
        return 1
    fi

    for package_name in "$@"; do
        del_pkg "$package_name"
    done
}

function gst_ros_set_ws() {
    # if no argument, then source the config file, else set the config file
    if [ -z "$1" ]; then
        if [ -f "$GST_ROS_CONF_FILE" ]; then
            source "$GST_ROS_CONF_FILE"
            if [ -z "$GST_SELECTED_ROS_WS" ]; then
                log_error "ROS workspace not set in file $GST_ROS_CONF_FILE."
                return 1
            fi
        else
            log_error "ROS workspace config file not found at '$GST_ROS_CONF_FILE'"
            return 1
        fi
    else
        export GST_SELECTED_ROS_WS="$1"
    fi

    # Convert to absolute path (handles both relative and absolute inputs)
    local full_path
    if [ -d "$GST_SELECTED_ROS_WS" ]; then
        full_path="$(realpath "$GST_SELECTED_ROS_WS")"
    else
        log_error "Directory '$GST_SELECTED_ROS_WS' does not exist"
        return 1
    fi
    
    # Validate it's a ROS workspace
    if [ ! -d "$full_path/src" ]; then
        log_error "'$full_path' is not a valid ROS workspace (missing src/ directory)"
        return 1
    fi
    
    # Update the stored workspace to the absolute path
    export GST_SELECTED_ROS_WS="$full_path"
    
    echo "export GST_SELECTED_ROS_WS='$GST_SELECTED_ROS_WS'" >"$GST_ROS_CONF_FILE"
    log_info "ROS workspace set to '$GST_SELECTED_ROS_WS'"
}

function gst_ros_get_ws() {
    if [ -z "$GST_SELECTED_ROS_WS" ]; then
        log_error "No ROS ('GST_SELECTED_ROS_WS') workspace selected."
        return 1
    fi
    echo "$GST_SELECTED_ROS_WS"
}

function cdws() {
    # TODO: Process arguments properly to cd into a given ws and, if -s given, source the <ws>/install/setup.bash

    local SOURCE_AFTER_CD=false
    local GIVEN_WS=''

    if [[ ! -z "$1" && "$1" != "-s" ]]; then
        GIVEN_WS="$1"
    fi

    if [[ "$@" == *"-s"* ]]; then
        SOURCE_AFTER_CD=true
    fi

    local target_ws
    if [ -z "$GIVEN_WS" ]; then
        # Use currently selected workspace
        target_ws=$(gst_ros_get_ws)
        if [ $? -ne 0 ]; then
            return 1
        fi
    else
        # Convert given path to absolute path
        if [ -d "$GIVEN_WS" ]; then
            target_ws="$(realpath "$GIVEN_WS")"
        else
            log_error "Workspace '$GIVEN_WS' does not exist"
            return 1
        fi
        
        # Validate it's a ROS workspace
        if [ ! -d "$target_ws/src" ]; then
            log_error "'$target_ws' is not a valid ROS workspace"
            return 1
        fi
    fi

    cd "$target_ws" || return 1

    if $SOURCE_AFTER_CD; then
        rsrc
    fi
}


