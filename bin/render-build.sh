#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
# Precompile assets and clean up
echo "Precompiling assets and cleaning up..."
RAILS_ENV=production bundle exec rails assets:precompile
RAILS_ENV=production bundle exec rails assets:clean


echo "Build completed successfully."