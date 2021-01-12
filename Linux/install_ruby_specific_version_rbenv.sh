#!/bin/bash

# Prerequisites -  NodeJS 

echo "##### Runnig script under $USER #####"

# Set a specific Ruby version
export RUBY_VERSION=2.6.2 

echo "##### Installing Dependencies #####" 
# Installing dependencies
sudo apt update 
sudo apt install -y curl git autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm5 libgdbm-dev libsqlite3-dev

# Installing nodejs
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash - 
sudo apt-get install -y nodejs 

# Copying rbenv - rbenv and ruby-build repositories from GitHub.
sudo git clone https://github.com/rbenv/rbenv.git /usr/local/rbenv

sudo echo '# rbenv setup' > /etc/profile.d/rbenv.sh
sudo echo 'export RBENV_ROOT=/usr/local/rbenv' >> /etc/profile.d/rbenv.sh
sudo echo 'export PATH="$RBENV_ROOT/bin:$PATH"' >> /etc/profile.d/rbenv.sh
sudo echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh
sudo chmod +x /etc/profile.d/rbenv.sh
sudo source /etc/profile.d/rbenv.sh

sudo git clone https://github.com/rbenv/ruby-build.git /usr/local/rbenv/plugins/ruby-build

echo "##### Installing Ruby and set it global #####" 
# Install Ruby version and set it to default version
rbenv install $RUBY_VERSION 
rbenv global $RUBY_VERSION 

# Checking Ruby version
ruby -v 

# In case it fails with The Ruby openssl extension was not compiled used the following config.
# export RUBY_CONFIGURE_OPTS="--with-openssl-dir=/usr/lib/ssl"
# Or install this library apt install libssl1.0-dev