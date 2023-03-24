#!/bin/bash
#title           :omada-controller-installer.sh
#description     :Automated installation of the latest version of Omada Controller
#supported       :Ubuntu 16.04, Ubuntu 18.04, Ubuntu 20.04
#updated         :24/03/2023

# Check if the script is running on a supported version of Ubuntu
if ! [[ $(lsb_release -rs) =~ ^(16.04|18.04|20.04)$ ]]; then
  echo "This script only supports Ubuntu 16.04, 18.04, and 20.04."
  exit 1
fi

# Install MongoDB 4.4 and OpenJDK-8
echo "Installing MongoDB 4.4 and OpenJDK-8..."
wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu $(lsb_release -cs)/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list
sudo apt-get update -qq
sudo apt-get install -y openjdk-8-jre-headless mongodb-org

# Install the latest version of Omada Controller
echo "Installing the latest version of Omada Controller..."
OmadaPackageUrl=$(curl -s https://www.tp-link.com/support/download/omada-software-controller/ | grep -oP '(?<=href=")[^"]*Omada_SDN_Controller_v\d+\.\d+\.\d+_Linux_x64\.deb[^"]*')
wget $OmadaPackageUrl -P /tmp/
sudo dpkg -i /tmp/$(basename $OmadaPackageUrl)

# Show IP address of the machine
ip_address=$(hostname -I | awk '{print $1}')
echo "Installation complete! You can access the Omada Controller at https://${ip_address}:8043"
