#!/bin/sh

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

sudo git clone https://github.com/rbenv/rbenv.git  /var/opt/rbenv

sudo groupadd rubyusers
sudo usermod -a -G rubyusers $USER
sudo chgrp -R rubyusers /var/opt/rbenv/
sudo chmod 0775 /var/opt/rbenv
sudo chmod g+s -R /var/opt/rbenv/

echo 'export RBENV_ROOT=/var/opt/rbenv' | sudo tee -a '/etc/profile.d/rbenv.sh'
echo 'export PATH=$RBENV_ROOT/bin:$PATH' | sudo tee -a '/etc/profile.d/rbenv.sh'
echo 'eval "$(rbenv init -)"' | sudo tee -a '/etc/profile.d/rbenv.sh'
sudo chgrp rubyusers /etc/profile.d/rbenv.sh
sudo chmod +x /etc/profile.d/rbenv.sh
source /etc/profile.d/rbenv.sh


sudo git clone https://github.com/rbenv/ruby-build.git /var/opt/rbenv/plugins/ruby-build

echo "##### Installing Ruby and set it global #####" 
# Install Ruby version and set it to default version
rbenv install $RUBY_VERSION 
rbenv global $RUBY_VERSION 

# Checking Ruby version
ruby -v 

# In case it fails with The Ruby openssl extension was not compiled used the following config.
# export RUBY_CONFIGURE_OPTS="--with-openssl-dir=/usr/lib/ssl"
# Or install this library apt install libssl1.0-dev