#!/bin/bash
# Created by: Jonathan Mikler
# Creation Date: 29/February/24

bash .get_toolbox_location.sh
if [ -f .env ]; then
    cat generic_shell_toolbox >> ~/.bashrc
fi

source ~/.bashrc

echo "Installation complete."
