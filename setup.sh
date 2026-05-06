#!/bin/bash
set -e

echo "=== UPDATE ==="
sudo apt update

echo "=== INSTALL PACKAGES ==="
sudo apt install -y nginx postgresql nodejs npm

echo "=== CREATE USERS ==="
sudo useradd -m student || true
sudo useradd -m teacher || true
sudo useradd -m operator || true
sudo useradd -r -s /usr/sbin/nologin app || true

echo "=== SET PASSWORDS ==="
echo "student:qwerty1234" | sudo chpasswd
echo "teacher:12345678" | sudo chpasswd
echo "operator:123456789" | sudo chpasswd

echo "=== CREATE DATABASE ==="
sudo -u postgres psql -c "CREATE DATABASE mywebapp;" || true

echo "=== RUN MIGRATIONS ==="
sudo -u postgres psql mywebapp < migrations/init.sql

echo "=== COPY SYSTEMD ==="
sudo cp mywebapp.service /etc/systemd/system/

echo "=== ENABLE SERVICE ==="
sudo systemctl daemon-reload
sudo systemctl enable mywebapp
sudo systemctl restart mywebapp

echo "=== SETUP NGINX ==="
sudo cp nginx.conf /etc/nginx/sites-available/mywebapp
sudo ln -sf /etc/nginx/sites-available/mywebapp /etc/nginx/sites-enabled/mywebapp
sudo systemctl restart nginx

echo "=== GRADEBOOK FILE ==="
echo "7" | sudo tee /home/student/gradebook

echo "=== DISABLE DEFAULT USER ==="
sudo passwd -l veronika || true


echo "=== DONE ==="
