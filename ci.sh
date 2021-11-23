#!/bin/bash
set -e
xcodebuild -project 'shortcut code challenge UIKit.xcodeproj' -scheme 'shortcut code challenge UIKit' -destination 'platform=iOS Simulator,name=iPhone 8' test
xcodebuild -project 'shortcut code challenge UIKit.xcodeproj' -scheme 'shortcut code challenge UIKit' -destination 'generic/platform=iOS' -configuration Release build CODE_SIGNING_ALLOWED=NO
