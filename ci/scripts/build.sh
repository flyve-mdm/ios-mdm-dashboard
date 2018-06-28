#!/bin/sh

xcodebuild clean build -workspace ${APPNAME}.xcworkspace -scheme $APPNAME CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO