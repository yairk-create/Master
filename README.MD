# Nginx Configuration Automation Script

## Overview

This repository contains a bash script that automates the setup and configuration of Nginx with several advanced features:
- User directory support
- Basic authentication
- PAM authentication 
- CGI scripting capabilities

The script offers an argument-based system to selectively install and configure each feature as needed.

## Features

### Core Functionality
- **Nginx Installation Check**: Verifies if Nginx is already installed on the system.
- **Virtual Host Configuration**: Checks for existing virtual hosts and assists with setting up new ones.
- **Dependency Management**: Automatically identifies and installs required dependencies.
- **Modular Installation**: Provides command-line arguments to selectively install specific features.

### Supported Nginx Features
- **User Directory**: Configures user-specific web directories (similar to Apache's `userdir` module).
- **Authentication**: Sets up HTTP Basic Authentication for protected content.
- **PAM Authentication**: Integrates with Linux PAM for authentication against system users.
- **CGI Support**: Enables running CGI scripts within the Nginx environment.

## Requirements

- Debian/Ubuntu-based Linux distribution (tested on Ubuntu 20.04+)
- Sudo/root privileges
- Bash shell

## Usage

```bash
./nginx_setup.sh [OPTIONS]
```

### Available Options

```
-h, --help            Display this help message
-v, --virtual-host    Configure a new virtual host
-u, --user-dir        Install and configure user directory support
-a, --auth            Setup basic authentication
-p, --pam-auth        Configure PAM authentication
-c, --cgi             Enable CGI scripting
-A, --all             Install and configure all features
```

### Examples

Install Nginx and configure a virtual host:
```bash
./nginx_setup.sh -v example.com
```

Setup only user directories:
```bash
./nginx_setup.sh -u
```

Install all features:
```bash
./nginx_setup.sh -A
```

## Implementation Details

### Virtual Host Configuration
The script creates a server block in `/etc/nginx/sites-available/` and enables it by creating a symbolic link in `/etc/nginx/sites-enabled/`.

### User Directory Structure
When enabled, users can serve content from `~/public_html/` which will be accessible at `http://example.com/~username/`.

### Authentication
Basic authentication creates password-protected directories with credentials stored in `.htpasswd` files.

### PAM Authentication
Integrates with the system's PAM authentication mechanism to allow access based on system user accounts.

### CGI Implementation
Configures Nginx to process CGI scripts, enabling dynamic content generation through scripts.

## Troubleshooting

If you encounter issues:
1. Check the Nginx error logs: `/var/log/nginx/error.log`
2. Ensure all dependencies are correctly installed
3. Verify that Nginx configuration syntax is correct with `nginx -t`
4. Confirm proper file permissions for all created configuration files

## Related Resources

This script is based on the Nginx configuration guidelines from:
[Nginx Shallow Dive](https://gitlab.com/vaiolabs-io/nginx-shallow-dive)

## Contributing

Contributions to improve the script are welcome. Please feel free to submit pull requests or open issues for bugs and feature requests.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
