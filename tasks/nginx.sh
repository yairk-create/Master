#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color


# variable definition
#LOG_FILE="/home/yair/my_project/tasks/var/nginx_setup.log"
#LOG_DIR="/home/yair/my_project/tasks/var"

check_priviliges() {

if [[ $EUID -ne 0 ]]; then
    printf "\n${BOLD}${YELLOW}This script requires root privileges.\n"
    printf "Re-launching with sudo.\n\n"
    exec sudo "$0" "$@"  # Restart script with sudo
    exit 1
fi

}

check_nginx_installed() {

"INFO"  "Checking if Nginx is installed"

if command -v ngnix > dev/null;then
printf "\n${RED} Nginx is not installed.\n"

fi





}
