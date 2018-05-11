#! /bin/sh

echo "Shutting down old simulators"

username=$(whoami)
xcrun simctl --set "/Users/$username/Library/Developer/XCTestDevices" shutdown all

echo "Done!"
