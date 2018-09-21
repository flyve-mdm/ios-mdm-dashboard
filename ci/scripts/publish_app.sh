#!/bin/sh

if [[ $GITHUB_COMMIT_MESSAGE != *"ci(release): generate CHANGELOG.md for version"* && $GITHUB_COMMIT_MESSAGE != *"ci(build): release version"* ]]; then

    # Update app info
    source "${SCRIPT_PATH}/app_info.sh"
    # Send app to App Store with fastlane 
    bundle exec fastlane publish

if
