#!/bin/bash

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
# Update CFBundleShortVersionString
/usr/libexec/PlistBuddy -c "Set :CFBundleShortVersionString ${GIT_TAG}" ${PWD}/${APPNAME}/Info.plist
# Update CFBundleVersion
/usr/libexec/PlistBuddy -c "Set :CFBundleVersion $CIRCLE_BUILD_NUM" ${PWD}/${APPNAME}/Info.plist
# Add modified and delete files
git add ${APPNAME}/Info.plist
git commit --amend --no-edit

echo "Generate code coverage reporting with xcov"
# Generate code coverage reporting with xcov
bundle exec fastlane coverage

# Add coverage folder
git add coverage -f
# Create commit, NOTICE: this commit is not sent
git commit -m "ci(docs): generate **coverage** for version ${GIT_TAG}"
# Update coverage on gh-pages branch
yarn gh-pages --dist coverage --dest "${COVERAGE_DESTINATION}${CIRCLE_BRANCH}" -m "ci(docs): generate coverage with xcov for version ${GIT_TAG}"

echo "Generate test report"
# Create header content to test report
echo "---" > header.html
echo "layout: modal" >> header.html
echo "---" >> header.html

# Add header to test report
(cat header.html ; cat fastlane/test_output/report.html) > fastlane/test_output/index.html
# Remove test report copy
rm fastlane/test_output/report.html
rm header.html

# Generate test report
yarn gh-pages --dist fastlane/test_output --src index.html --dest "${TEST_REPORT_DESTINATION}${CIRCLE_BRANCH}" -m "ci(docs): generate test report for version ${GIT_TAG}"
