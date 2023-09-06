#!/bin/bash
sudo apt update -y 
sudo apt install ansible -y
sudo apt-get install software-properties-common -y
sudo apt-add-repository universe
sleep 3
sudo apt-get update -y
sudo apt-get install python3 -y
sudo apt-get install python3-pip -y
sudo pip install boto3 botocore

