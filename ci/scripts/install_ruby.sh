#!/bin/sh

# update ruby
brew install ruby
# Update gem
gem update --system
# Clean Gem
gem cleanup
# Install gems from Gemfile
bundle install --path vendor/bundle
# Update fastlane plugin
bundle exec fastlane update_plugins
