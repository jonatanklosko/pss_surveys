#!/bin/bash

# Confirm whether the user aims to run the script
read -p "Do you want to set up SSL certificate with Let's Encrypt? (y/n) "
if [[ ! $REPLY =~ ^[Yy]$ ]]; then exit; fi
# Use Let’s Encrypt for obtaining free SSL certificates
# Install Certbot an ACME client
sudo apt-get update -y
sudo apt-get install -y software-properties-common
sudo add-apt-repository -y ppa:certbot/certbot
sudo apt-get update -y
sudo apt-get install -y python-certbot-nginx
# Request certificate and update Nginx configuration
sudo certbot --nginx -d www.ankiety.kostkarubika.org -d ankiety.kostkarubika.org
