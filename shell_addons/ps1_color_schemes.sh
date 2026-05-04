#!/usr/bin/env bash
# Predefined PS1 color schemes. Each function exports GST_PS1_C_* variables
# consumed by PS1_config.sh to build the full prompt.

# Dark terminal, no bold (matches the classic toolbox look)
function _gst_scheme_dark_default() {
    export GST_PS1_C_USER='\[\e[38;5;47m\]'
    export GST_PS1_C_AT='\[\e[38;5;156m\]'
    export GST_PS1_C_HOST='\[\e[38;5;227m\]'
    export GST_PS1_C_CWD='\[\e[38;5;231m\]'
    export GST_PS1_C_GIT_REPO='\[\e[38;5;160m\]'
    export GST_PS1_C_GIT_BRANCH='\[\e[38;5;196m\]'
    export GST_PS1_C_RESET='\[\033[0m\]'
}

# Dark terminal, bold (see issue #47)
function _gst_scheme_dark_bold() {
    export GST_PS1_C_USER='\[\e[1;38;5;28m\]'
    export GST_PS1_C_AT='\[\e[1;38;5;107m\]'
    export GST_PS1_C_HOST='\[\e[1;38;5;178m\]'
    export GST_PS1_C_CWD='\[\e[1;38;5;245m\]'
    export GST_PS1_C_GIT_REPO='\[\e[1;38;5;88m\]'
    export GST_PS1_C_GIT_BRANCH='\[\e[1;38;5;124m\]'
    export GST_PS1_C_RESET='\[\033[0m\]'
}

# Light terminal, no bold
function _gst_scheme_light_default() {
    export GST_PS1_C_USER='\[\e[38;5;22m\]'
    export GST_PS1_C_AT='\[\e[38;5;58m\]'
    export GST_PS1_C_HOST='\[\e[38;5;94m\]'
    export GST_PS1_C_CWD='\[\e[38;5;240m\]'
    export GST_PS1_C_GIT_REPO='\[\e[38;5;88m\]'
    export GST_PS1_C_GIT_BRANCH='\[\e[38;5;124m\]'
    export GST_PS1_C_RESET='\[\033[0m\]'
}

# Light terminal, bold
function _gst_scheme_light_bold() {
    export GST_PS1_C_USER='\[\e[1;38;5;22m\]'
    export GST_PS1_C_AT='\[\e[1;38;5;58m\]'
    export GST_PS1_C_HOST='\[\e[1;38;5;94m\]'
    export GST_PS1_C_CWD='\[\e[1;38;5;240m\]'
    export GST_PS1_C_GIT_REPO='\[\e[1;38;5;88m\]'
    export GST_PS1_C_GIT_BRANCH='\[\e[1;38;5;124m\]'
    export GST_PS1_C_RESET='\[\033[0m\]'
}

GST_PS1_SCHEMES=("dark_default" "dark_bold" "light_default" "light_bold")

function gst_load_ps1_scheme() {
    local scheme="${1:-${GST_PS1_COLOR_SCHEME:-dark_default}}"
    case "$scheme" in
        dark_default)  _gst_scheme_dark_default ;;
        dark_bold)     _gst_scheme_dark_bold ;;
        light_default) _gst_scheme_light_default ;;
        light_bold)    _gst_scheme_light_bold ;;
        *)
            echo "Unknown PS1 scheme '$scheme', falling back to 'dark_default'."
            _gst_scheme_dark_default
            ;;
    esac
}
