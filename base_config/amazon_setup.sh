#!/bin/bash
set -e

# Install necessary dependencies
echo '> Installing Update ...'
echo 'yes' | sudo yum update
sudo yum -y -qq install curl wget git vim apt-transport-https ca-certificates curl gnupg lsb-release

# Install docker
echo '> Installing Docker ...'
sudo amazon-linux-extras install docker
sudo service docker start
sudo chkconfig docker on

# Install docker-compose
echo '> Installing docker-compose ...'
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Setup sudo to allow no-password sudo for "ansible" group and adding "ansible" user
echo '> Creating User...'
sudo useradd -m -s /bin/bash ansible
sudo usermod -aG docker ansible
sudo cp /etc/sudoers /etc/sudoers.orig
echo "ansible ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/ansible

# Installing SSH key
echo '> Creating SSH Key Files...'
sudo mkdir -p /home/ansible/.ssh
sudo chmod 700 /home/ansible/.ssh
sudo cp /tmp/ansible.pub /home/ansible/.ssh/authorized_keys
sudo chmod 600 /home/ansible/.ssh/authorized_keys
sudo chown -R ansible /home/ansible/.ssh
sudo usermod --shell /bin/bash ansible