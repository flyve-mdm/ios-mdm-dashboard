#!/bin/sh

# update ruby
brew install ruby
# Update gem
gem update --system
# Clean Gem
gem cleanup
# Install jazzy for generate documentation
gem install jazzy
# Install jq for json parse
brew install jq
# Install transifex-client
easy_install pip
pip install transifex-client
# Install libs from package.json
yarn install
# Install gems from Gemfile
bundle install --path vendor/bundle
# Update fastlane plugin
bundle exec fastlane update_plugins
