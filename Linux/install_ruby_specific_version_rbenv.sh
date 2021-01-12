#!/bin/bash

# Prerequisites -  NodeJS 

h=$HOME
echo "##### Using $HOME #####"

# Set a specific Ruby version
export RUBY_VERSION=2.6.2 

echo "##### Installing Dependencies #####" 
# Installing dependencies
sudo apt update 
sudo apt install -y curl git autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm5 libgdbm-dev libsqlite3-dev

# Installing nodejs
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash - 
sudo apt-get install -y nodejs 

# Copying rbenv - rbenv and ruby-build repositories from GitHub to ~/.rbenv directory.
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
source ~/.bashrc

echo "##### Installing Ruby and set it global #####" 
# Install Ruby version and set it to default version
rbenv install $RUBY_VERSION 
rbenv global $RUBY_VERSION 

# Checking Ruby version
ruby -v 

# In case it fails with The Ruby openssl extension was not compiled used the following config.
# export RUBY_CONFIGURE_OPTS="--with-openssl-dir=/usr/lib/ssl"
# Or install this library apt install libssl1.0-dev