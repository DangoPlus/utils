#!/bin/bash

set -e

# Step 1: Update the package list
echo "Updating package list..."
 apt update

# Step 2: Install required packages
echo "Installing required packages..."
 apt install -y ca-certificates curl

# Step 3: Create the necessary directory
echo "Creating directory for Docker's GPG key..."
 install -m 0755 -d /etc/apt/keyrings

# Step 4: Download Docker's GPG key
echo "Downloading Docker's official GPG key..."
 curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
 chmod a+r /etc/apt/keyrings/docker.asc

# Step 5: Add Docker's repository to Apt sources
echo "Adding Docker repository to Apt sources..."
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
   tee /etc/apt/sources.list.d/docker.list > /dev/null

# Step 6: Update the package list again
echo "Updating package list again..."
 apt update

echo "Docker repository setup completed!"

echo "Installing Docker..."
 apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
echo "Docker installation completed!"

# chmod +x setup_docker_repo.sh
# ./setup_docker_repo.sh

#  apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin