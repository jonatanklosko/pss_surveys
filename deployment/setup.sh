#!/bin/bash

# Confirm whether the user aims to run the script
read -p "Do you want to install everything needed for the app to run? (y/n) "
if [[ ! $REPLY =~ ^[Yy]$ ]]; then exit; fi
# Install rbenv
sudo apt-get update -y
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
source ~/.bashrc
rbenv -v
# Install rbenv-build plugin to install new versions of Ruby easily.
mkdir -p "$(rbenv root)"/plugins
git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
# Install necessary packages for ruby-build (see https://github.com/rbenv/ruby-build/wiki#suggested-build-environment)
apt-get install -y autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev
# Install Node.js
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo apt-get install -y build-essential
node -v
npm -v
# Install Yarn
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update -y && sudo apt-get install -y yarn
yarn -v
# Install Nginx
sudo apt-get install -y nginx
# Install PostgreSQL
sudo apt-get install -y postgresql postgresql-contrib libpq-dev
# Create database user
echo "Creating new database user. Enter password for him when prompted."
sudo -u postgres createuser -s pss_surveys --pwprompt
# Clone the repository and cd into it
git clone https://github.com/jonatanklosko/pss_surveys.git && cd pss_surveys
# Install appropriate version of Ruby
rbenv install $(cat .ruby-version)
ruby -v
# Install Ruby dependencies
gem install bundler
bundle install --deployment --without test development
# Create file for environment configuration
cp scripts/.env.production_template .env.production
# Set up the database
RAILS_ENV=production bin/rails db:setup
# Compile assets
RAILS_ENV=production bin/rails assets:clean assets:precompile
# Print instructions for the user what else needs to be configured.
echo -e "\n\n"
echo -e "\033[0;32m✓ Installation finished!"
echo -e "\033[0;33m! TODO:"
echo -e "\033[0;34m    - Fill .env.production with appropriate environment configuration."
echo -e "\033[0;34m    - Add Nginx configuration under /etc/nginx/sites-available/"
