#!/usr/bin/env bash
# Created by Jonathan Mikler on 29/February/24

# get the absolute path of the 'generic_shell_toolbox' directory and writes it to a .env file inside of it

main(){
    script_dir=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
    echo "Toolbox location: $script_dir"

    if [ -f "$script_dir/.env" ]; then
        source "$script_dir/.env"
        echo "file .env already exists"
        echo "Toolbox location: ${GENERIC_SHELL_TOOLBOX_LOCATION}"
        read -p "Do you want to replace it with '${script_dir}'? (y/n): " replace_env

        if [ "$replace_env" == "y" ]; then
            echo "export GENERIC_SHELL_TOOLBOX_LOCATION=$script_dir" > "$script_dir/.env"
            source "$script_dir/.env"
            echo "The .env file has been replaced."
        fi
    else
        echo "export GENERIC_SHELL_TOOLBOX_LOCATION=$script_dir" > "$script_dir/.env"
        source "$script_dir/.env"
        echo "The .env file has been created."
    fi

    # decide if including a default PS1 configuration
    read -p "Do you want to include a default PS1 configuration? (y/n): " include_PS1

    if [ "$include_PS1" == "y" ]; then
        local default_PS1="\[\e[38;5;47m\]\u\[\e[38;5;156m\]@\[\e[38;5;227m\]\h \[\e[38;5;231m\]\w \[\033[0m\]$ "
        echo "export PS1='$default_PS1'" >> "$script_dir/.env"
        echo "The default PS1 has been added to the .env file."
    fi
}

main