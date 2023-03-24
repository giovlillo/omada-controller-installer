#!/bin/bash
#title           :omada-controller-installer.sh
#description     :Automated installation of the latest version of Omada Controller
#supported       :Ubuntu 16.04, Ubuntu 18.04, Ubuntu 20.04
#updated         :24/03/2023

# Check OS version and exit if not Ubuntu 16.04, 18.04 or 20.04
if ! [[ "$(lsb_release -r | awk '{print $2}')" =~ ^(16.04|18.04|20.04)$ ]]; then
  echo "This script only supports Ubuntu 16.04, 18.04 or 20.04. Exiting."
  exit 1
fi

# Update apt and install dependencies
sudo apt update
sudo apt install -y openjdk-8-jre-headless jsvc curl

# Install MongoDB 4.4
wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu $(lsb_release -cs)/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list
sudo apt update
sudo apt install -y mongodb-org

# Install Omada Controller
omada_url=$(curl -s https://www.tp-link.com/en/support/download/omada-software-controller/ | grep -o -m 1 'https://static.tp-link.com/[^"]*x64.deb')
omada_filename=$(basename "$omada_url")
wget "$omada_url"
sudo dpkg -i "$omada_filename"
sudo apt install -fy

# Get server IP address
ip=$(hostname -I | awk '{print $1}')

echo "Omada Controller installed successfully at http://$ip:8088"

