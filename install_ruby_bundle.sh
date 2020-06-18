#!/bin/bash                                                                                              
# You need to change RUBY_VERSION_TO_INSTALL and BUNDLER_VERSION with desired versions.                                                                                                      
#Downloading rbenv                                                                                       
                                                                                                         
rm -rf /usr/local/.rbenv/                                                                                
                                                                                                         
git clone https://github.com/rbenv/rbenv.git /usr/local/.rbenv                                           
chmod -R 777 /usr/local/.rbenv                                                                           
export RBENV_ROOT="/usr/local/.rbenv"                                                                    
export PATH="$RBENV_ROOT/bin:/usr/local:$PATH"                                                           
                                                                                                         
                                                                                                         
#Downloading ruby build                                                                                  
git clone https://github.com/rbenv/ruby-build.git /usr/local/.rbenv/plugins/ruby-build                   
chmod -R 777 /usr/local/.rbenv/plugins/ruby-build                                                        
/usr/local/.rbenv/plugins/ruby-build/install.sh                                                          
export RUBY_CFLAGS=-O3                                                                                   
                                                                                                         
#Enable rbenv                                                                                            
eval "$(rbenv init -)"                                                                                   
export RUBY_VERSION_TO_INSTALL="2.6.2"                                                                   
rbenv install $RUBY_VERSION_TO_INSTALL                                                                   
rbenv rehash                                                                                             
rbenv global $RUBY_VERSION_TO_INSTALL                                                                    
export BUNDLER_VERSION="1.17.2"                                                                          
gem install bundler --version $BUNDLER_VERSION                                                           
chmod -R 777 /usr/local/.rbenv/versions                                                                  
chmod -R 777 /usr/local/.rbenv/version                                                                   
                                                                                                         
#Activate everything                                                                                     
eval "$(rbenv init -)"                                                                                   
rbenv global $RUBY_VERSION_TO_INSTALL                                                                    