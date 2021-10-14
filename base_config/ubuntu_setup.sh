#!/bin/bash
set -e

# Install necessary dependencies
echo '> Installing Update ...'
sudo apt update
echo 'yes' | sudo apt upgrade
sudo apt-get -y -qq install curl wget git vim apt-transport-https ca-certificates curl gnupg lsb-release

# Install docker
echo '> Installing docker ...'
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
sudo echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
echo 'yes' | sudo apt-get install docker-ce docker-ce-cli containerd.io

echo '> Installing docker-compose ...'
# Install docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

echo '> Adding Ansible User ...'
# Setup sudo to allow no-password sudo for "ansible" group and adding "ansible" user
sudo useradd -m -s /bin/bash ansible
sudo usermod -aG docker ansible
sudo cp /etc/sudoers /etc/sudoers.orig
echo "ansible ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/ansible

echo '> Installing SSH Key Files ...'
# Installing SSH key
sudo mkdir -p /home/ansible/.ssh
sudo chmod 700 /home/ansible/.ssh
sudo cp /tmp/ansible.pub /home/ansible/.ssh/authorized_keys
sudo chmod 600 /home/ansible/.ssh/authorized_keys
sudo chown -R ansible /home/ansible/.ssh
sudo usermod --shell /bin/bash ansible