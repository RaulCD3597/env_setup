#!/bin/bash

if docker version &>/dev/null; then
  echo "docker already installed."

  exit 0
fi

# remove any unofficial docker packages, disable command errors in case of missing packages to remove
set +e
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done

# exit on errors, now any arror should stop the script
set -e

echo "Installing Docker..."

# add docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# add the repository to apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" |
  sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
sudo apt-get update

# install docker
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# enable docker without sudo
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker

# enable docker to start on boot
sudo systemctl enable docker.service
sudo systemctl enable containerd.service
