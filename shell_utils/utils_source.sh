_gst_load_utils(){
    source "${GENERIC_SHELL_TOOLBOX_LOCATION}/shell_utils/colored_shell.sh"
    source "${GENERIC_SHELL_TOOLBOX_LOCATION}/shell_utils/aliases.sh"

    source "${GENERIC_SHELL_TOOLBOX_LOCATION}/shell_utils/uninstall.sh"
}

_gst_load_utils
unset -f _gst_load_utils