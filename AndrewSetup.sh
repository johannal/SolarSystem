#! /bin/sh

echo "Configuring SOTU defaults for Andrew"

# To enable the default device set:
defaults write com.apple.dt.Xcode DVTTestSimulatorCloneProviderUseDefaultSet -bool YES

# To disable the purge policy [Options are aggressive, moderate, relaxed] (39444847)
defaults write com.apple.dt.Xcode DVTTestDeviceClonePoolPurgePolicy -string relaxed

# To override the number of simulators we will boot (38960788)
defaults write com.apple.dt.Xcode IDETestingMaxParallelSimulatorClones -int 3

echo "Configuring SOTU defaults for Andrew [DONE]"
