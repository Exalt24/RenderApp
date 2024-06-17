#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
bundle exec rails assets:precompile
bundle exec rails assets:clean
RAILS_ENV=test bundle exec rails db:migrate  # Ensure test database schema is up to date
RAILS_ENV=test bundle exec rails test  # Run all tests in the test environment

echo "Build completed successfully."