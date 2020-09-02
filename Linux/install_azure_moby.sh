# Reference https://docs.microsoft.com/en-us/azure/iot-edge/how-to-install-iot-edge-linux

# Download Microsoft Software Repository for Production
curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
sudo apt-add-repository https://packages.microsoft.com/ubuntu/$(lsb_release -r -s)/prod

# Update repositories
sudo apt-get update

# Installing Docker Azure Moby
sudo apt-get install -y moby-engine
sudo apt-get install -y moby-cli

# Printing docker version
echo $(docker -v)

# Add docker group and user to docker group
sudo groupadd docker
sudo usermod -aG docker $USER

# Adding user to sudoers 
sudo usermod -aG sudo $USER

# Enabling userns-remap
sudo echo > /etc/docker/daemon.json <<EOF
{
  "userns-remap":"default"
}
EOF

# Reload and start
sudo systemctl daemon-reload
sudo systemctl restart docker
sudo systemctl start docker