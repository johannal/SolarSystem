#! /bin/sh

echo "Clearing old defaults"
defaults delete com.apple.dt.Xcode DVTTestSimulatorCloneProviderUseDefaultSet
defaults delete com.apple.dt.Xcode IDETestingMaxParallelSimulatorClones

echo "Configuring demo defaults"

# To disable the purge policy [Options are aggressive, moderate, relaxed] (39508904 & 39444847)
defaults write com.apple.dt.Xcode DVTTestDeviceClonePoolPurgePolicy -string relaxed

# Set the max number of simulators we will boot (39509217 & 38960788)
defaults write com.apple.dt.Xcode IDEParallelTestingWorkerCountOverride -int 3

# If Xcode crashes, we want to repopulate the pool with any clones that already exist, so we don’t boot again
defaults write com.apple.dt.Xcode DVTTestDeviceClonePoolPopulateWithPreexistingClones -bool YES

echo "Done!"
