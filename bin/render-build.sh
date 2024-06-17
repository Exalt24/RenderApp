#!/usr/bin/env bash
# exit on error
set -o errexit

# Install all required gems specified in Gemfile.lock
bundle install --without development test

# Precompile assets for production
bundle exec rails assets:precompile

# Clean up assets after precompilation (optional, but can be useful to reduce disk space usage)
bundle exec rails assets:clean

# Ensure no tests are being run in production
if [ "$RAILS_ENV" == "production" ]; then
  echo "Ensuring no test files are being executed..."
  if ls test/*.rb 1> /dev/null 2>&1 || ls spec/*.rb 1> /dev/null 2>&1; then
    echo "Test files found! Please remove or move them out of the production deployment."
    exit 1
  fi
fi

# Run database migrations
bundle exec rails db:migrate
