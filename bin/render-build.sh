#!/usr/bin/env bash
# exit on error
set -o errexit

# Install dependencies
bundle install
yarn install # or npm install, depending on your project

# Precompile assets
./bin/rails assets:precompile

# Run database migrations
./bin/rails db:migrate

# Clean up assets (remove old assets)
./bin/rails assets:clean