#!/bin/sh
# After running this script with  sudo sh install_ruby_specific_version_rbenv.sh use sudo su to use ruby.

echo "##### Runnig script under $1 #####"

# Set a specific Ruby version
export RUBY_VERSION=2.7.3 

echo "##### Installing NodeJS and Yarn #####" 
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

# Installing dependencies
sudo apt-get update 
sleep 15

# Installing nodejs
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash - 
sudo apt-get install -y nodejs 

# Installing yarn
sudo apt install yarn

echo "##### Installing Dependencies #####" 
# Installing dependencies
sudo apt-get update 
sudo apt-get install -y libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm5 libgdbm-dev libsqlite3-dev
sleep 15
sudo apt-get install -y curl git autoconf bison build-essential gcc 



# Copying rbenv - rbenv and ruby-build repositories from GitHub.

sudo git clone https://github.com/rbenv/rbenv.git  /var/opt/rbenv
sudo chmod 777 -R /var/opt/rbenv/

echo 'export RBENV_ROOT=/var/opt/rbenv' | sudo tee -a '/etc/profile.d/rbenv.sh'
echo 'export PATH=$RBENV_ROOT/bin:$PATH' | sudo tee -a '/etc/profile.d/rbenv.sh'
echo 'eval "$(rbenv init -)"' | sudo tee -a '/etc/profile.d/rbenv.sh'
sudo chmod +x /etc/profile.d/rbenv.sh
. /etc/profile.d/rbenv.sh

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

sudo chown -R $1 /var/opt/rbenv/