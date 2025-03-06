#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color


# variable definition
#LOG_FILE="/home/yair/my_project/tasks/var/nginx_setup.log"
#LOG_DIR="/home/yair/my_project/tasks/var"

function check_priviliges() {

if [[ $EUID -ne 0 ]]; then
    printf "\n${YELLOW}This script requires root privileges.\n"
    printf "Re-launching with sudo.\n\n"
    exec sudo "$0" "$@"  # Restart script with sudo
    exit 1
fi

}

function check_nginx_installed() {
    printf "\n${GREEN} Checking if Nginx is installed.\n"
    
    if command -v nginx > /dev/null 2>&1; then
        printf "\n${GREEN} Nginx is already installed.\n"
        return 0
        else
        printf "\n${BLUE} trying to install nginx.\n"
        sudo apt update && sudo apt install nginx -y
        return 0
    fi
        
        if ! command -v nginx > /dev/null 2>&1; then
            
            printf "\n${RED} Nginx  failedto be installed.\n" 
        fi


        
    
}


function check_vhost() {
      local website="/etc/nginx/sites-enabled/"
    if [[ -z $website  ]];then
    printf "\n${RED} virtual host is not configured"
    fi

    read -p "\n${BLUE}To configure virtual host Enter the domain name for the virtual host (e.g., example.com): " domain_name
    
    if [ -z "$domain_name" ]; then
        echo -e "${RED}No domain name provided. Skipping virtual host configuration.${NC}"
        return 1
    fi
    
    # Create directory structure
    mkdir -p /var/www/$domain_name/html
    chown -R www-data:www-data /var/www/$domain_name
    chmod -R 755 /var/www/$domain_name
    
    # Create a sample index.html
    cat > /var/www/$domain_name/html/index.html << EOF
<!DOCTYPE html>
<html>
<head>
    <title>Welcome to $domain_name</title>
</head>
<body>
    <h1>Success! $domain_name is working!</h1>
</body>
</html>
EOF
    
    # Create the virtual host configuration file
    cat > /etc/nginx/sites-available/$domain_name << EOF
server {
    listen 80;
    listen [::]:80;
    
    root /var/www/$domain_name/html;
    index index.html index.htm index.nginx-debian.html;
    
    server_name $domain_name www.$domain_name;
    
    location / {
        try_files \$uri \$uri/ =404;
    }
}
EOF
    
    # Enable the virtual host
    if [ -d /etc/nginx/sites-enabled ]; then
        ln -s /etc/nginx/sites-available/$domain_name /etc/nginx/sites-enabled/
    fi
    
    # Test nginx configuration
    nginx -t
    if [ $? -eq 0 ]; then
        systemctl reload nginx
        echo -e "${GREEN}Virtual host for $domain_name has been configured successfully.${NC}"
        return 0
    else
        echo -e "${RED}Nginx configuration test failed. Please check the syntax.${NC}"
        return 1
    fi
}


   




















function main(){



check_priviliges
check_nginx_installed
}