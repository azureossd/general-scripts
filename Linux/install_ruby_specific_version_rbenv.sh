#!/bin/bash
# Important
# Run "sudo su" before running this script or give access to your user.
# Prerequisites -  NodeJS 

u="$USER"
echo "#####User name $u #####"
sudo usermod -aG sudo $u

h=$HOME
echo "##### Using $HOME #####"

# Installing nodejs
curl -sL https://deb.nodesource.com/setup_14.x | bash - 
apt-get install -y nodejs 

# Set a specific Ruby version
export RUBY_VERSION=2.6.2 

echo "##### Installing Dependencies #####" 
# Installing dependencies
apt update 
apt install -y git curl libssl-dev libreadline-dev zlib1g-dev autoconf bison build-essential libyaml-dev libreadline-dev libncurses5-dev libffi-dev libgdbm-dev libsqlite3-dev 

# Copying rbenv - rbenv and ruby-build repositories from GitHub to ~/.rbenv directory.
curl -sL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-installer | bash - 

# Adding rbenv bin directory to user PATH
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc 
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
source ~/.bashrc

echo "##### Installing Ruby and set it global #####" 
# Install Ruby version and set it to default version
rbenv install $RUBY_VERSION >> $logpath
rbenv global $RUBY_VERSION >> $logpath

# Checking Ruby version
ruby -v >> $logpath

# In case it fails with The Ruby openssl extension was not compiled used the following config.
# export RUBY_CONFIGURE_OPTS="--with-openssl-dir=/usr/lib/ssl"
# Or install this library apt install libssl1.0-dev