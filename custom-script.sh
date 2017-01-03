#!/usr/bin/env bash

set -eux

# Sample custom configuration script - add your own commands here
# to add some additional commands for your environment
#
# For example:
# yum install -y curl wget git tmux firefox xvfb
# Install docker
sudo tee /etc/yum.repos.d/docker.repo <<-'EOF'
[dockerrepo]
name=Docker Repository
baseurl=https://yum.dockerproject.org/repo/main/centos/$releasever/
enabled=1
gpgcheck=1
gpgkey=https://yum.dockerproject.org/gpg
EOF

sudo yum install -y docker-engine-1.12.5

# Enable docker to take commands over http
sudo mkdir -p /etc/systemd/system/docker.service.d
sudo tee /etc/systemd/system/docker.service.d/docker.conf <<-'EOF'
[Service]
ExecStart=
ExecStart=/usr/bin/docker daemon -H tcp://0.0.0.0:2375 -H unix:///var/run/docker.sock
EOF

# Docker starts at boot.
sudo chkconfig docker on

# Add the docker admin to the docker group
usermod -a -G docker dockeradmin

# Docker-Compose
sudo curl -o /usr/local/bin/docker-compose -L https://github.com/docker/compose/releases/download/1.8.1/docker-compose-`uname -s`-`uname -m`
sudo chmod +x /usr/local/bin/docker-compose

sudo yum install -y java-1.8.0-openjdk java-1.8.0-openjdk-devel net-tools wget

# Install latest git
cd ~
sudo yum install -y epel-release
wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo rpm -Uvh epel-release-latest-7*.rpm

wget https://centos7.iuscommunity.org/ius-release.rpm
sudo rpm -Uvh ius-release*.rpm

sudo yum install -y git2u

# Prevent further yum updates
echo -e "\nexclude=*\n" | sudo tee -a /etc/yum.conf
