# Define colors:
NC='\033[0m'
GREEN_TXT='\e[0;32m'
GREEN_TXT2='\e[32m'
LIGHT_GREEN_TXT='\e[92m'
DARK_GREEN_TXT='\e[2;32m'

WHITE_TXT='\e[1;37m'
RED_TXT='\e[31m'
# DIM_RED_TXT='\e[2;31m'
LIGHT_BLUE_TXT='\e[96m'
# BLUE_TXT='\e[34m'
# DIM_BLUE_TXT='\e[2;34m'
# DARK_GREY_TXT='\e[90m'
YELLOW_TXT='\e[93m'
# BOLDRED="\033[1m\033[31m"     # /* Bold Red */
# BOLDGREEN="\033[1m\033[32m"   # /* Bold Green */
# BOLDYELLOW="\033[1m\033[33m"  # /* Bold Yellow */
# BOLDBLUE="\033[1m\033[34m"    # /* Bold Blue */
# BOLDMAGENTA="\033[1m\033[35m" # /* Bold Magenta */
# BOLDCYAN="\033[1m\033[36m"    # /* Bold Cyan */
# BOLDWHITE="\033[1m\033[37m"   # /* Bold White */

function log_info() {
    printf "$@\n"
}

function log_info_blue() {
    printf "${LIGHT_BLUE_TXT}$@${NC}\n"
}

function log_info_red() {
    printf "${RED_TXT}$@${NC}\n"
}

function log_info_yellow() {
    printf "${YELLOW_TXT}$@${NC}\n"
}

function log_info_green() {
    printf "${GREEN_TXT2}$@${NC}\n"
}

function log_warn() {
    printf "${YELLOW_TXT}$@${NC}\n"
}

function log_info_important() {
    l=$(expr length "$@")
    c=$(($l + 2))
    pad=""
    pading_sym="─"
    while [[ $c > 0 ]]; do
        pad="$pad$pading_sym"
        c=$((c - 1))
    done
    printf "${LIGHT_BLUE_TXT}┌$pad┐${NC}\n"
    printf "${LIGHT_BLUE_TXT}│ $@ │${NC}\n"
    printf "${LIGHT_BLUE_TXT}└$pad┘${NC}\n"
}

function log_error() {
    printf "${RED_TXT}$@${NC}\n"
}

function log_debug() {
    printf "${LIGHT_GREEN_TXT}$@${NC}\n"
}