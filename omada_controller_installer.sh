#!/bin/bash

# Check if user is root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

# Check if running on supported Ubuntu versions
if [[ $(lsb_release -rs) != "16.04" && $(lsb_release -rs) != "18.04" && $(lsb_release -rs) != "20.04" ]]; then
    echo "This script can only be run on Ubuntu 16.04, 18.04, or 20.04"
    exit 1
fi

# Install required dependencies
apt-get update && apt-get install -y curl openjdk-8-jdk jsvc

# Add MongoDB repository and install MongoDB 4.4
wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu $(lsb_release -cs)/mongodb-org/4.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.4.list
apt-get update && apt-get install -y mongodb-org

# Download Omada SDN Controller package
curl -s https://www.tp-link.com/en/support/download/omada-software-controller/ | grep -Eo 'https://static.tp-link.com/'$(curl -s https://www.tp-link.com/en/support/download/omada-software-controller/ | grep -Eo 'Omada_SDN_Controller_v[0-9]+\.[0-9]+\.[0-9]+_Linux_x64\.deb')'[a-zA-Z0-9/\._-]+' | xargs curl -O

# Install Omada SDN Controller package
dpkg -i Omada_SDN_Controller_*.deb

# Start Omada SDN Controller service
systemctl start omada.service

# Show IP address and port to access Omada SDN Controller web interface
IP=$(ip -4 route get 8.8.8.8 | awk '{print $7}')
echo "Omada SDN Controller is running at http://$IP:8088"
