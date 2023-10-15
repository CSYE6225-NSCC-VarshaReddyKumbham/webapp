#!/bin/bash
# MySQL root password
mysql_root_password='Geethareddy@1989'

# Update the package repository information
sudo apt update

# Install MariaDB Server
sudo apt install -y mariadb-server

# Start the MariaDB service
sudo systemctl start mariadb

# Enable MariaDB to start on boot
sudo systemctl enable mariadb

# Secure the MariaDB installation (remove anonymous users, etc.)
mysql -u root <<EOF
UPDATE mysql.user SET authentication_string=PASSWORD('$mysql_root_password') WHERE User='root';
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
FLUSH PRIVILEGES;
EOF

sudo systemctl restart mariadb

echo "MariaDB installation completed!"

# Update the package repository information
sudo apt update

# Install Node.js and npm
sudo apt install -y nodejs npm

# Print Node.js and npm versions
echo "Node.js version:"
node -v

echo "npm version:"
npm -v

echo "Node.js and npm installation completed!"