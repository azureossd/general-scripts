#!/bin/bash
# Important
# Run "sudo su" before running this script or give access to your user.
# Prerequisites 

u="$USER"
echo "User name $u"
sudo usermod -aG sudo $u

logpath=/var/log/deploymentScriptLog

sudo echo "##### Installing NodeJS #####" >> $logpath
# Installing nodejs
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash - >> $logpath
sudo apt-get install -y nodejs >> $logpath

# Set a specific Ruby version
export RUBY_VERSION=2.6.2 

sudo echo "##### Installing Dependencies #####" >> $logpath
# Installing dependencies
sudo apt update >> $logpath
sudo apt install -y git curl libssl-dev libreadline-dev zlib1g-dev autoconf bison build-essential libyaml-dev libreadline-dev libncurses5-dev libffi-dev libgdbm-dev libsqlite3-dev >> $logpath

# Copying rbenv - rbenv and ruby-build repositories from GitHub to ~/.rbenv directory.
curl -sL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-installer | sudo bash - >> $logpath

# Adding rbenv bin directory to user PATH
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc 
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
source ~/.bashrc

sudo echo "##### Installing Ruby and set it global #####" >> $logpath
# Install Ruby version and set it to default version
sudo rbenv install $RUBY_VERSION >> $logpath
sudo rbenv global $RUBY_VERSION >> $logpath

# Checking Ruby version
ruby -v >> $logpath

# In case it fails with The Ruby openssl extension was not compiled used the following config.
# export RUBY_CONFIGURE_OPTS="--with-openssl-dir=/usr/lib/ssl"
# Or install this library apt install libssl1.0-dev