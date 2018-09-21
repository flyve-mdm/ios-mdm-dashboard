#!/bin/bash

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

if [[ $GITHUB_COMMIT_MESSAGE != *"ci(release): generate CHANGELOG.md for version"* && $GITHUB_COMMIT_MESSAGE != *"ci(build): release version"* ]]; then
  
  # Get old version number from package.json
  export GIT_OLD_TAG=$(jq -r ".version" package.json)
  # Generate CHANGELOG.md and increment version
  IS_PRERELEASE="$( cut -d '-' -f 2 <<< "$GIT_OLD_TAG" )";

  if [[ $GIT_TAG != "$IS_PRERELEASE" ]]; then

    PREFIX_PRERELEASE="$( cut -d '.' -f 1 <<< "$IS_PRERELEASE" )";
    yarn release -t '' --skip.bump=true -m "ci(release): generate CHANGELOG.md for version %s" --prerelease "$PREFIX_PRERELEASE"

  else

    yarn release -t '' --skip.bump=true -m "ci(release): generate CHANGELOG.md for version %s"

  fi

  # Get version number from package.json
  export GIT_TAG=$(jq -r ".version" package.json)

  echo "Update CHANGELOG.md on gh-pages"
  # Create header content to CHANGELOG.md
  echo "---" > header.md
  echo "layout: modal" >> header.md
  echo "title: changelog" >> header.md
  echo "---" >> header.md

  # Duplicate CHANGELOG.md
  cp CHANGELOG.md CHANGELOG_COPY.md
  # Add header to CHANGELOG.md
  (cat header.md ; cat CHANGELOG_COPY.md) > CHANGELOG.md
  # Remove CHANGELOG_COPY.md
  rm CHANGELOG_COPY.md
  rm header.md
  # Update CHANGELOG.md on gh-pages
  yarn gh-pages --dist ./ --src CHANGELOG.md --dest ./ --add -m "ci(docs): generate CHANGELOG.md for version ${GIT_TAG}"
  # Reset CHANGELOG.md
  git checkout CHANGELOG.md -f

  # Update CFBundleShortVersionString
  /usr/libexec/PlistBuddy -c "Set :CFBundleShortVersionString ${GIT_TAG}" "${PWD}/${APPNAME}/Info.plist"
  # Update CFBundleVersion
  /usr/libexec/PlistBuddy -c "Set :CFBundleVersion $CIRCLE_BUILD_NUM" "${PWD}/${APPNAME}/Info.plist"
  # Add modified and delete files
  git add -u
  # Create commit
  git commit -m "ci(build): release version ${GIT_TAG}"

  # Push commits and tags to origin branch
  git push --follow-tags origin $CIRCLE_BRANCH
  echo "Create release with conventional-github-releaser"
  # Create release with conventional-github-releaser
  yarn conventional-github-releaser -p angular -t $GITHUB_TOKEN

  echo "Create Archive and ipa file"
  # Archive App and create ipa file
  bundle exec fastlane archive

  echo "Upload ipa file to release"
  # Upload ipa file to release
  yarn github-release upload \
  --user "$CIRCLE_PROJECT_USERNAME" \
  --repo "$CIRCLE_PROJECT_REPONAME" \
  --tag "${GIT_TAG}" \
  --name "${APPNAME}.ipa" \
  --file "${APPNAME}.ipa"

    # Update master branch
    git fetch origin master
    git checkout master
    git clean -d -x -f
    git merge $CIRCLE_BRANCH
    git push origin master

fi
