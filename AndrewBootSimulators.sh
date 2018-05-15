#! /bin/sh

username=$(whoami)
echo "Username is $username"

simcount=4
xcode=$(xcode-select -p)
echo "Will boot $simcount simulators using $xcode"

echo "Shutting down existing simulators"
xcrun simctl --set "/Users/$username/Library/Developer/XCTestDevices" shutdown all
rm -rf "/Users/$username/Library/Developer/XCTestDevices"

echo "Booting simulators"
XCODE_DEVELOPER_DIR="$xcode" ./sotubootsims --device-name 'iPhone 8' --count $simcount

echo "Listing simulators after boot"
xcrun simctl --set "/Users/$username/Library/Developer/XCTestDevices" list

echo "Done!"
