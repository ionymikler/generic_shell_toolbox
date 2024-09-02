#!/usr/bin/env bash
# Created by Jonathan Mikler on 27/June/24


# compilation of all extensions of GST
function source_extention(){
    source "${GENERIC_SHELL_TOOLBOX_LOCATION}/.extensions/$1/extension_setup.bash"
}

SCRIPT_DIR="$(dirname "${BASH_SOURCE[0]}")"
EXTENSIONS=(
    "gst-ros"
    )

main(){
    _DIR=$(realpath "$SCRIPT_DIR" )
    source "$_DIR/gst-ros/extension_setup.bash"

    echo "[GST] Extensions loaded"
}

main