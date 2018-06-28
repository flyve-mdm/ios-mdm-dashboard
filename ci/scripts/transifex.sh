#!/bin/sh

echo ------------------- Configure Transifex --------------------
# Configure Transifex on develop branch
# Create config file transifex
sudo echo $'[https://www.transifex.com]\nhostname = https://www.transifex.com\nusername = '"$TRANSIFEX_USER"$'\npassword = '"$TRANSIFEX_API_TOKEN"$'\ntoken = '"$TRANSIFEX_API_TOKEN"$'\n' > ~/.transifexrc
# get transifex status
tx status
# push local files to transifex
tx push --source --no-interactive
# pull all the new language
tx pull --all --force
# if there are changes in lenguages
if [[ -z $(git status -uno -s) ]]; then
    echo "tree is clean"
else
    git add -u
    git commit -m "ci(localization): download languages from Transifex"
fi
