#!/bin/bash

# Run the subsequent commands from application root level
cd $(dirname $0)/..
# Pull changes from remote repository if any
git pull
# Install dependencies if needed
bundle check || bundle install
# Compile assets
RAILS_ENV=production bin/rails assets:clean assets:precompile
# Migrate the database if needed
RAILS_ENV=production bin/rails db:migrate
# Restart Delayed Job
RAILS_ENV=production bin/delayed_job restart
# Either restart or run the server
if [ -f tmp/pids/puma.pid ]; then
  echo "Puma process found, restarting..."
  bin/rails restart
else
  echo "No puma process found, starting..."
  mkdir -p tmp/pids # Ensure the pids directory is here
  bundle exec puma -e production
fi
