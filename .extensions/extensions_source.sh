#!/usr/bin/env bash
# Created by Jonathan Mikler on 27/June/24

# compilation of all extensions of GST
# Wrapped in a function so the path stays local and nothing leaks into the user's shell.
_gst_load_extensions(){
    local dir
    dir=$(realpath "$(dirname "${BASH_SOURCE[0]}")")
    source "${dir}/gst-ros/extension_setup.bash"

    echo "[GST] Extensions loaded"
}

_gst_load_extensions
unset -f _gst_load_extensions
