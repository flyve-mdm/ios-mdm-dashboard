#!/bin/sh

echo ----------- Create Fastlane environment variables ------------
# Create Fastlane environment variables
echo FASTLANE_PASSWORD=$FASTLANE_PASSWORD >> .env
echo TELEGRAM_WEBHOOKS=$TELEGRAM_WEBHOOKS >> .env
echo GIT_REPO="$CIRCLE_PROJECT_USERNAME/$CIRCLE_PROJECT_REPONAME" >> .env
echo GIT_BRANCH=$CIRCLE_BRANCH >> .env
echo APPLE_ID=$APPLE_ID >> .env
echo APPLE_TEAM_ID=$APPLE_TEAM_ID >> .env
echo XCODE_SCHEME=$XCODE_SCHEME >> .env
echo XCODE_SCHEME_UI=$XCODE_SCHEME_UI >> .env
echo XCODE_WORKSPACE=$XCODE_WORKSPACE >> .env
echo APP_IDENTIFIER=$APP_IDENTIFIER >> .env
