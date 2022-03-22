#!/bin/bash

#Update repositories
sudo apt update
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
sudo apt update
apt-cache policy docker-ce

sudo apt-get install -y docker-ce docker-ce-cli containerd.io

echo $(docker -v)

sudo groupadd docker
sudo usermod -aG docker $USER

##Adding user to sudoers 
sudo usermod -aG sudo $USER
sudo systemctl start docker

## Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version

sudo su
su <user>
