#! /bin/sh

echo "Listing simulators"

username=$(whoami)
xcrun simctl --set "/Users/$username/Library/Developer/XCTestDevices" list

echo "Done!"
