#!/usr/bin/env bash
# Provides the gst_ps1_scheme command for listing and switching PS1 color schemes.

function gst_ps1_scheme() {
    local subcmd="${1:-list}"
    case "$subcmd" in
        list) _gst_ps1_scheme_list ;;
        set)  _gst_ps1_scheme_set "${2}" ;;
        *)
            echo "Usage: gst_ps1_scheme <list|set> [scheme_name]"
            return 1
            ;;
    esac
}

function _gst_ps1_scheme_list() {
    local current="${GST_PS1_COLOR_SCHEME:-dark_default}"
    echo "Available PS1 color schemes:"
    for scheme in "${GST_PS1_SCHEMES[@]}"; do
        if [ "$scheme" == "$current" ]; then
            echo "  * $scheme  (active)"
        else
            echo "    $scheme"
        fi
    done
}

function _gst_ps1_scheme_set() {
    local scheme="$1"
    if [ -z "$scheme" ]; then
        echo "Usage: gst_ps1_scheme set <scheme_name>"
        _gst_ps1_scheme_list
        return 1
    fi

    local valid=false
    for s in "${GST_PS1_SCHEMES[@]}"; do
        [ "$s" == "$scheme" ] && valid=true && break
    done

    if [ "$valid" == "false" ]; then
        echo "Unknown scheme '$scheme'. Run 'gst_ps1_scheme list' to see available schemes."
        return 1
    fi

    local env_file="${GENERIC_SHELL_TOOLBOX_LOCATION}/.env"
    if grep -q "GST_PS1_COLOR_SCHEME" "$env_file"; then
        sed -i "s|^export GST_PS1_COLOR_SCHEME=.*|export GST_PS1_COLOR_SCHEME='$scheme'|" "$env_file"
    else
        echo "export GST_PS1_COLOR_SCHEME='$scheme'" >> "$env_file"
    fi

    export GST_PS1_COLOR_SCHEME="$scheme"
    source "${GENERIC_SHELL_TOOLBOX_LOCATION}/shell_addons/PS1_config.sh"
    echo "PS1 color scheme set to '$scheme'."
}
