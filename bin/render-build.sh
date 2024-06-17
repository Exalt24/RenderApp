#!/usr/bin/env bash
# exit on error
set -o errexit

# Set RAILS_ENV explicitly to avoid production mode issues
export RAILS_ENV=production

# Install all required gems specified in Gemfile.lock
bundle install

# Precompile assets for production
bundle exec rails assets:precompile

# Clean up assets after precompilation (optional, but can be useful to reduce disk space usage)
bundle exec rails assets:clean


# bundle exec rake db:migrate RAILS_ENV=production
