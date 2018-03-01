#!/bin/bash

# Run the subsequent commands from application root level
cd $(dirname $0)/..
# Pull changes from remote repository if any
git pull
# Stop server and Delayed Job worker in order to have more memory for the build
if [ -f tmp/pids/puma.pid ]; then
  echo "Stopping Puma server..."
  kill $(cat tmp/pids/puma.pid)
fi
RAILS_ENV=production bin/delayed_job stop

# Install dependencies if needed
bundle check || bundle install
# Compile assets
RAILS_ENV=production bin/rails assets:clean assets:precompile
# Migrate the database if needed
RAILS_ENV=production bin/rails db:migrate

mkdir -p tmp/pids # Ensure the pids directory is here
# Start server and Delayed Job worker
echo "Starting Puma server..."
bundle exec puma -e production
RAILS_ENV=production bin/delayed_job start
