#!/bin/bash

set -e

# Step 1: Update the package list
echo "Updating package list..."
sudo apt update

# Step 2: Install required packages
echo "Installing required packages..."
sudo apt install -y ca-certificates curl

# Step 3: Create the necessary directory
echo "Creating directory for Docker's GPG key..."
sudo install -m 0755 -d /etc/apt/keyrings

# Step 4: Download Docker's GPG key
echo "Downloading Docker's official GPG key..."
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Step 5: Add Docker's repository to Apt sources
echo "Adding Docker repository to Apt sources..."
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Step 6: Update the package list again
echo "Updating package list again..."
sudo apt update

echo "Docker repository setup completed!"

# chmod +x setup_docker_repo.sh
# ./setup_docker_repo.sh

# sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin