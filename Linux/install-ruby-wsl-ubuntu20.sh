#!/bin/sh
# Running WSL with Ubuntu 20

echo "##### Validating for Node.js and yarn #####"

if node -v > /dev/null 2>&1; then
      echo "Node is installed"
		
else
      echo "Node is not installed"
      echo "##### Installing Node.js 14 version #####" 
	    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
      sudo apt-get update 
      curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash - 
	    sudo apt-get install -y nodejs 
fi


if yarn -v > /dev/null 2>&1; then
      echo "Yarn is installed"
		
else
      echo "Yarn is not installed"
      echo "##### Installing Yarn #####" 
	    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
      sudo apt-get update 
	    sudo apt install yarn
fi

export RUBY_VERSION=2.6.2 
sudo rm -rf /usr/local/share/rbenv
sudo apt-get update 
sudo apt-get install -y libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libsqlite3-dev
sudo apt-get install -y curl git autoconf bison build-essential gcc 
sudo git clone https://github.com/rbenv/rbenv.git  /usr/local/share/rbenv/
sudo chmod 777 -R /usr/local/share/rbenv/

echo 'export RBENV_ROOT=/usr/local/share/rbenv' | sudo tee -a '/etc/profile.d/rbenv.sh'
echo 'export PATH=$RBENV_ROOT/bin:$PATH' | sudo tee -a '/etc/profile.d/rbenv.sh'
echo 'eval "$(rbenv init -)"' | sudo tee -a '/etc/profile.d/rbenv.sh'
sudo chmod +x /etc/profile.d/rbenv.sh
. /etc/profile.d/rbenv.sh

sudo git clone https://github.com/rbenv/ruby-build.git /usr/local/share/rbenv/plugins/ruby-build

echo "##### Installing Ruby and set it global #####" 
# Install Ruby version and set it to default version
rbenv install $RUBY_VERSION 
rbenv global $RUBY_VERSION 

# Checking Ruby version
ruby -v 
sudo chown -R $USER /usr/local/share/rbenv/
