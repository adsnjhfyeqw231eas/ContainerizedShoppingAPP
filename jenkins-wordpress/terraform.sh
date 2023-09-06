#!/bin/bash
sudo apt update -y
sudo apt install zip unzip -y
sleep 1
wget https://releases.hashicorp.com/terraform/1.5.6/terraform_1.5.6_linux_amd64.zip
sleep 1
unzip terraform_1.5.6_linux_amd64.zip
sleep 1
sudo mv -v terraform /usr/local/bin
rm -f terraform_1.5.6_linux_amd64.zip
#sudo apt install awscli -y

