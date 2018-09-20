#!/bin/sh

# Update app info
source "${SCRIPT_PATH}/app_info.sh"
# Send app to App Store with fastlane 
bundle exec fastlane publish