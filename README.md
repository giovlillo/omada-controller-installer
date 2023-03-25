# Omada Controller Installer
This script automates the installation of the Omada Controller software on Ubuntu 16.04, 18.04, and 20.04. The script installs MongoDB 4.4 and OpenJDK-8 as dependencies, and then downloads and installs the latest version of the Omada Controller software from the official TP-Link website.

## Prerequisites
This script only works on Ubuntu 16.04, 18.04, and 20.04. You must have sudo privileges to run the script.

## Installation
To install the Omada Controller software, run the following command in your terminal:


``` curl -s https://raw.githubusercontent.com/giovlillo/omada-controller-installer/main/omada_controller_installer.sh | sudo bash ```

The installation process will begin, and the script will automatically download and install MongoDB 4.4, OpenJDK-8, and the latest version of the Omada Controller software.

## Usage
Once the installation is complete, you can access the Omada Controller by opening a web browser and navigating to the following URL:

``` https://<server-ip-address>:8088```

Replace <server-ip-address> with the IP address of the machine where the Omada Controller is installed.

## License
Please note that this script is licensed under the MIT License, so use it at your own risk.

## Reference
 
[Download for Omada Software Controller](https://www.tp-link.com/en/support/download/omada-software-controller/)
 
[Which ports do Omada Controller and EAP Discovery Utility use?](https://www.tp-link.com/us/support/faq/3265/)
