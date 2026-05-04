#!/bin/bash
# Created by: Jonathan Mikler
# Creation Date: 29/February/24

SCRIPT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source "${SCRIPT_PATH}/shell_utils/colored_shell.sh"

source "${SCRIPT_PATH}/.make_env_file.sh"

function set_color_scheme(){
    local scheme="${1:-dark_default}"
    echo "export GST_PS1_COLOR_SCHEME='$scheme'" >> "$SCRIPT_PATH/.env"
    echo "PS1 color scheme '$scheme' has been saved."
}

function add_to_bashrc(){
    local _sourcing_file_path="$HOME/.bashrc"
    echo "source ${GENERIC_SHELL_TOOLBOX_LOCATION}/generic_shell_toolbox.sh" >> $_sourcing_file_path

    # remember in env file
    echo "SOURCING_FILE_PATH=$_sourcing_file_path" >> "$SCRIPT_PATH/.env"

    log_info_green "The 'generic_shell_toolbox.sh' has been added to your bashrc file. Open a new terminal to see the changes."
}

function show_help() {
    echo "Generic Shell Toolbox Installation Script"
    echo ""
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  -h, --help    Show this help message and exit"
    echo "  -y            Auto-answer 'yes' to all prompts (non-interactive mode)"
    echo "  -D            Set default configuration (includes PS1 scheme and bashrc integration)"
    echo ""
    echo "Examples:"
    echo "  $0            # Interactive installation with prompts"
    echo "  $0 -y         # Non-interactive installation, auto-yes to all"
    echo "  $0 -D         # Install with default configuration"
    echo "  $0 -y -D      # Non-interactive with default configuration"
}

install_gst(){
    local SET_DEFAULT_CONFIG='false'
    local AUTO_YES='false'

    # Check for help flag first
    if [[ "$@" == *"-h"* ]] || [[ "$@" == *"--help"* ]]; then
        show_help
        return 0
    fi

    log_debug "$@"
    if [[ "$@" == *"-D"* ]]; then
        SET_DEFAULT_CONFIG=true
    fi
    if [[ "$@" == *"-y"* ]]; then
        AUTO_YES=true
    fi
    log_debug "SET_DEFAULT_CONFIG: $SET_DEFAULT_CONFIG, AUTO_YES: $AUTO_YES"

    # read version from dir_path/version.yaml
    local _version=$(cat "${SCRIPT_PATH}/version.yaml")
    log_info_blue "Installing the 'generic_shell_toolbox' $_version... \n"

    make_env_file

    # decide PS1 color scheme
    local _scheme_choice=""

    if [ "$SET_DEFAULT_CONFIG" == "true" ] || [ "$AUTO_YES" == "true" ]; then
        set_color_scheme "dark_default"
    else
        echo "* Available PS1 color schemes:"
        echo "    1) dark_default   - dark terminal, no bold  (default)"
        echo "    2) dark_bold      - dark terminal, bold"
        echo "    3) light_default  - light terminal, no bold"
        echo "    4) light_bold     - light terminal, bold"
        read -p "* Select a PS1 color scheme (1-4, press Enter for default): " _scheme_choice
        case "$_scheme_choice" in
            2) set_color_scheme "dark_bold" ;;
            3) set_color_scheme "light_default" ;;
            4) set_color_scheme "light_bold" ;;
            *) set_color_scheme "dark_default" ;;
        esac
    fi

    # decide if adding the 'generic_shell_toolbox.sh' to the bashrc file
    local paste_to_bashrc="n"
    
    if [ "$SET_DEFAULT_CONFIG" == "true" ] || [ "$AUTO_YES" == "true" ]; then
        paste_to_bashrc="y"
    else
        read -p "* Do you want to add the 'generic_shell_toolbox.sh' to your bashrc file? (y/n): " paste_to_bashrc
    fi

    if [ "$paste_to_bashrc" == "y" ]; then
        add_to_bashrc
    fi

    log_info_green "Installation complete"

}

install_gst "$@"

