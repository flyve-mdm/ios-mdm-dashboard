#!/bin/sh

#
#  LICENSE
# 
#  This file is part of Flyve MDM Admin Dashboard for iOS.
#
#  Admin Dashboard for iOS is a subproject of Flyve MDM.
#  Flyve MDM is a mobile device management software.
# 
#  Flyve MDM is free software: you can redistribute it and/or
#  modify it under the terms of the GNU General Public License
#  as published by the Free Software Foundation; either version 3
#  of the License, or (at your option) any later version.
#
#  Flyve MDM is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#  -------------------------------------------------------------------
#  @author    Hector Rondon - <hrondon@teclib.com>
#  @copyright Copyright Teclib. All rights reserved.
#  @license   LGPLv3 https://www.gnu.org/licenses/lgpl-3.0.html
#  @link      https://github.com/flyve-mdm/ios-mdm-dashboard/
#  @link      http://flyve.org/ios-mdm-dashboard/
#  @link      https://flyve-mdm.com
#  -------------------------------------------------------------------
#

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

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
