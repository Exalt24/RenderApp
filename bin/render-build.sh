#!/usr/bin/env bash
# exit on error
set -o errexit

# Install all required gems specified in Gemfile.lock
bundle config set without 'development test' && bundle install

# Precompile assets for production
bundle exec rails assets:precompile

# Clean up assets after precompilation (optional, but can be useful to reduce disk space usage)
bundle exec rails assets:clean

# Remove test files
echo "Cleaning up test files..."
rm -rf test/
rm -rf spec/

# Run database migrations
DISABLE_DATABASE_ENVIRONMENT_CHECK=1 bundle exec rake db:migrate:reset
