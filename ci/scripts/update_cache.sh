#!/bin/sh

# LICENSE
#
# screenshots.sh is part of FlyveMDMAdminDashboard
#
# FlyveMDMAdminDashboard is a subproject of Flyve MDM. Flyve MDM is a mobile
# device management software.
#
# FlyveMDMAdminDashboard is free software: you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 3
# of the License, or (at your option) any later version.
#
# FlyveMDMAdminDashboard is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# ------------------------------------------------------------------------------
# @author    Hector Rondon <hrondon@teclib.com>
# @copyright Copyright © Teclib. All rights reserved.
# @license   LGPLv3 https://www.gnu.org/licenses/lgpl-3.0.html
# @link      https://github.com/flyve-mdm/ios-mdm-dashboard.git
# @link      http://flyve.org/ios-mdm-dashboard
# @link      https://flyve-mdm.com
# ------------------------------------------------------------------------------

if [[ $CIRCLE_BRANCH == "develop" ]]; then

  # Get old version number from package.json
  export GIT_OLD_TAG=$(jq -r ".version" package.json)
  # Generate CHANGELOG.md and increment version
  IS_PRERELEASE="$( cut -d '-' -f 2 <<< "$GIT_OLD_TAG" )";

  if [[ $GIT_OLD_TAG != "$IS_PRERELEASE" ]]; then

    PREFIX_PRERELEASE="$( cut -d '.' -f 1 <<< "$IS_PRERELEASE" )";
    yarn release -t '' --skip.tag=true -m "ci(release): generate CHANGELOG.md for version %s" --prerelease "$PREFIX_PRERELEASE"

  else

    yarn release -t '' --skip.tag=true -m "ci(release): generate CHANGELOG.md for version %s"

  fi

fi

# Get version number from package.json
export GIT_TAG=$(jq -r ".version" package.json)

# Send untracked files to stash
git add .
git stash
# Checkout to gh-pages branch
git fetch origin gh-pages
git checkout gh-pages -f
git pull origin gh-pages

echo "Update cache"
# Create header content to cache
echo "---" > header_cache
echo "cache_version: $CIRCLE_SHA1" >> header_cache
echo "---" >> header_cache
# Remove header from file
sed -e '1,3d' sw.js > cache_file
rm sw.js
# Add new header
(cat header_cache ; cat cache_file) > sw.js
# Remove temp files
rm cache_file
rm header_cache
# Add sw.js to git
git add -u
# Create commit
git commit -m "ci(cache): force update cache for version ${GIT_TAG}"

# Push commit to origin gh-pages branch
git push origin gh-pages