#! /bin/sh

username=$(whoami)
echo "Username is $username"

simcount=4
xcode="/Volumes/Justice/Xcode.app"
echo "Will boot $simcount simulators using $xcode"

# echo "Shutting down existing simulators"
# xcrun simctl --set "/Users/$username/Library/Developer/XCTestDevices" shutdown all

echo "Booting simulators"
XCODE_DEVELOPER_DIR="$xcode/Contents/Developer" ./sotubootsims --device-name 'iPhone X' --count $simcount

echo "Listing simulators after boot"
xcrun simctl --set "/Users/$username/Library/Developer/XCTestDevices" list

echo "Done!"
