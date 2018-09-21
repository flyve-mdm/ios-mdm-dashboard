#!/bin/bash

if [[ $GITHUB_COMMIT_MESSAGE != *"ci(release): generate CHANGELOG.md for version"* && $GITHUB_COMMIT_MESSAGE != *"ci(build): release version"* ]]; then

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

  echo "Generate documentation with jazzy"
  # Generate documentation with jazzy
  jazzy
  mv docs/ code-documentation/  
  # Add docs folder
  git add code-documentation -f
  # Create commit, NOTICE: this commit is not sent
  git commit -m "ci(docs): generate **docs** for version ${GIT_TAG}"
  # Update documentation on gh-pages branch
  yarn gh-pages --dist code-documentation --dest "${DOCUMENTATION_DESTINATION}${CIRCLE_BRANCH}" -m "ci(docs): generate documentation with jazzy for version ${GIT_TAG}"

fi
