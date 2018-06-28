#!/bin/sh

# Get version app
GIT_TAG=$(jq -r ".version" package.json)
# Update about.strings file
echo "\"version\" = \"$GIT_TAG\";" > "$APPNAME/about.strings"
echo "\"build\" = \"$CIRCLE_BUILD_NUM\";" >> "$APPNAME/about.strings"
echo "\"date\" = \"$(date "+%a %b %d %H:%M:%S %Y")\";" >> "$APPNAME/about.strings"
echo "\"commit\" = \"${CIRCLE_SHA1:0:7}\";" >> "$APPNAME/about.strings"
echo "\"commit_full\" = \"$CIRCLE_SHA1\";" >> "$APPNAME/about.strings"
# Add about.strings to git
git add -u
# Create commit
git commit -m "ci(build): update build info to version ${GIT_TAG}"
