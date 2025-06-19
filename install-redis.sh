#!/bin/bash

set -e

if redis-cli --version &>/dev/null; then
  echo "redis already installed."
  echo "ensuring redis server is running..."
  sudo systemctl enable redis-server
  sudo systemctl start redis-server

  exit 0
fi

echo "Installing Redis..."

sudo apt-get install lsb-release curl gpg
curl -fsSL https://packages.redis.io/gpg | sudo gpg --dearmor -o /usr/share/keyrings/redis-archive-keyring.gpg
sudo chmod 644 /usr/share/keyrings/redis-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/redis-archive-keyring.gpg] https://packages.redis.io/deb $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/redis.list
sudo apt-get update
sudo apt-get -y install redis
