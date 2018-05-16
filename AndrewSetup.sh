#! /bin/sh

username=$(whoami)
echo "Username is $username"

simcount=4
echo "Simulator count for demo is $simcount"

simname="iPhone 8"
echo "Target simulator for the demo is $simname"

xcode=$(xcode-select -p)
echo "Selected Xcode path is $xcode"

echo "Clearing old defaults"
defaults delete com.apple.dt.Xcode

echo "Killing old core simulator services"
sudo killall CoreSimulatorService

echo "Configuring user defaults to disable Xcode behaviors"
defaults write com.apple.dt.Xcode '{
    "Xcode.AlertEvents" =     {
        "Xcode.AlertEvent.BuildNewIssues" =         {
            "Xcode.Alert.Bounce" =             {
                enabled = 0;
            };
            "Xcode.Alert.Dialog" =             {
                enabled = 0;
            };
            "Xcode.Alert.FirstIssue" =             {
                destination = firstIssue;
                enabled = 0;
            };
            "Xcode.Alert.RunScript" =             {
                enabled = 0;
            };
            "Xcode.Alert.ShowDebugger" =             {
                action = show;
                destination = workspace;
                enabled = 0;
                visibility = 0;
            };
            "Xcode.Alert.ShowNavigator" =             {
                action = 0;
                enabled = 0;
                navigator = "Xcode.IDEKit.Navigator.Issues";
            };
            "Xcode.Alert.ShowTab" =             {
                enabled = 0;
                tabTarget = 0;
            };
            "Xcode.Alert.Sound" =             {
                enabled = 0;
                soundPath = "/System/Library/Sounds/Sosumi.aiff";
            };
            "Xcode.Alert.Speech" =             {
                enabled = 0;
                voice = "com.apple.speech.synthesis.voice.Alex";
            };
        };
        "Xcode.AlertEvent.FiledRadar" =         {
            "Xcode.Alert.Dialog" =             {
                enabled = 1;
            };
        };
        "Xcode.AlertEvent.RunGeneratesOutput" =         {
            "Xcode.Alert.Bounce" =             {
                enabled = 0;
            };
            "Xcode.Alert.Dialog" =             {
                enabled = 0;
            };
            "Xcode.Alert.FirstIssue" =             {
                destination = firstIssue;
                enabled = 0;
            };
            "Xcode.Alert.RunScript" =             {
                enabled = 0;
            };
            "Xcode.Alert.ShowDebugger" =             {
                action = show;
                destination = workspace;
                enabled = 0;
                visibility = 0;
            };
            "Xcode.Alert.ShowNavigator" =             {
                action = 0;
                enabled = 0;
                navigator = "Xcode.IDEKit.Navigator.Structure";
            };
            "Xcode.Alert.ShowTab" =             {
                enabled = 0;
                tabTarget = 0;
            };
            "Xcode.Alert.Sound" =             {
                enabled = 0;
                soundPath = "/System/Library/Sounds/Sosumi.aiff";
            };
            "Xcode.Alert.Speech" =             {
                enabled = 0;
                voice = "com.apple.speech.synthesis.voice.Alex";
            };
        };
        "Xcode.AlertEvent.RunPauses" =         {
            "Xcode.Alert.Bounce" =             {
                enabled = 0;
            };
            "Xcode.Alert.Dialog" =             {
                enabled = 0;
            };
            "Xcode.Alert.FirstIssue" =             {
                destination = firstIssue;
                enabled = 0;
            };
            "Xcode.Alert.RunScript" =             {
                enabled = 0;
            };
            "Xcode.Alert.ShowDebugger" =             {
                action = show;
                destination = workspace;
                enabled = 0;
                visibility = 0;
            };
            "Xcode.Alert.ShowNavigator" =             {
                action = 0;
                enabled = 0;
                navigator = "Xcode.IDEKit.Navigator.Debug";
            };
            "Xcode.Alert.ShowTab" =             {
                enabled = 0;
                tabTarget = 0;
            };
            "Xcode.Alert.Sound" =             {
                enabled = 0;
                soundPath = "/System/Library/Sounds/Sosumi.aiff";
            };
            "Xcode.Alert.Speech" =             {
                enabled = 0;
                voice = "com.apple.speech.synthesis.voice.Alex";
            };
        };
        "Xcode.AlertEvent.TestingNewIssues" =         {
            "Xcode.Alert.Bounce" =             {
                enabled = 0;
            };
            "Xcode.Alert.Dialog" =             {
                enabled = 0;
            };
            "Xcode.Alert.FirstIssue" =             {
                destination = firstIssue;
                enabled = 0;
            };
            "Xcode.Alert.RunScript" =             {
                enabled = 0;
            };
            "Xcode.Alert.ShowDebugger" =             {
                action = show;
                destination = workspace;
                enabled = 0;
                visibility = 0;
            };
            "Xcode.Alert.ShowNavigator" =             {
                action = 0;
                enabled = 0;
                navigator = "Xcode.IDEKit.Navigator.Test";
            };
            "Xcode.Alert.ShowTab" =             {
                enabled = 0;
                tabTarget = 0;
            };
            "Xcode.Alert.Sound" =             {
                enabled = 0;
                soundPath = "/System/Library/Sounds/Sosumi.aiff";
            };
            "Xcode.Alert.Speech" =             {
                enabled = 0;
                voice = "com.apple.speech.synthesis.voice.Alex";
            };
        };
        "Xcode.AlertEvent.TestingPauses" =         {
            "Xcode.Alert.Bounce" =             {
                enabled = 0;
            };
            "Xcode.Alert.Dialog" =             {
                enabled = 0;
            };
            "Xcode.Alert.FirstIssue" =             {
                destination = firstIssue;
                enabled = 0;
            };
            "Xcode.Alert.RunScript" =             {
                enabled = 0;
            };
            "Xcode.Alert.ShowDebugger" =             {
                action = show;
                destination = workspace;
                enabled = 0;
                visibility = 0;
            };
            "Xcode.Alert.ShowNavigator" =             {
                action = 0;
                enabled = 0;
                navigator = "Xcode.IDEKit.Navigator.Debug";
            };
            "Xcode.Alert.ShowTab" =             {
                enabled = 0;
                tabTarget = 0;
            };
            "Xcode.Alert.Sound" =             {
                enabled = 0;
                soundPath = "/System/Library/Sounds/Sosumi.aiff";
            };
            "Xcode.Alert.Speech" =             {
                enabled = 0;
                voice = "com.apple.speech.synthesis.voice.Alex";
            };
        };
    };
    "Xcode.AlertEvents.4_1" =     {
        "Xcode.AlertEvent.BotFailsBlameLocalUser" =         {
            "Xcode.Alert.Dialog" =             {
                enabled = 1;
            };
        };
        "Xcode.AlertEvent.BuildFails" =         {
            "Xcode.Alert.Dialog" =             {
                enabled = 1;
            };
        };
        "Xcode.AlertEvent.BuildNewIssues" =         {
            "Xcode.Alert.Bounce" =             {
                enabled = 0;
            };
            "Xcode.Alert.Dialog" =             {
                enabled = 0;
            };
            "Xcode.Alert.FirstIssue" =             {
                destination = firstIssue;
                enabled = 0;
            };
            "Xcode.Alert.RunScript" =             {
                enabled = 0;
            };
            "Xcode.Alert.ShowDebugger" =             {
                action = show;
                destination = workspace;
                enabled = 0;
                visibility = 0;
            };
            "Xcode.Alert.ShowEditor" =             {
                action = 0;
                enabled = 0;
                visibility = 0;
            };
            "Xcode.Alert.ShowNavigator" =             {
                action = 0;
                enabled = 0;
                navigator = "Xcode.IDEKit.Navigator.Issues";
            };
            "Xcode.Alert.ShowTab" =             {
                enabled = 0;
                tabTarget = 0;
            };
            "Xcode.Alert.ShowToolbar" =             {
                action = 0;
                enabled = 0;
            };
            "Xcode.Alert.ShowUtilityArea" =             {
                action = 0;
                enabled = 0;
            };
            "Xcode.Alert.Sound" =             {
                enabled = 0;
                soundPath = "/System/Library/Sounds/Sosumi.aiff";
            };
            "Xcode.Alert.Speech" =             {
                enabled = 0;
                voice = "com.apple.speech.synthesis.voice.Alex";
            };
        };
        "Xcode.AlertEvent.BuildStart" =         {
        };
        "Xcode.AlertEvent.BuildSucceeds" =         {
            "Xcode.Alert.Dialog" =             {
                enabled = 1;
            };
        };
        "Xcode.AlertEvent.FiledRadar" =         {
            "Xcode.Alert.Dialog" =             {
                enabled = 1;
            };
        };
        "Xcode.AlertEvent.FindCompletesNoResults" =         {
        };
        "Xcode.AlertEvent.FindCompletesWithResults" =         {
        };
        "Xcode.AlertEvent.InstallFails" =         {
            "Xcode.Alert.Dialog" =             {
                enabled = 1;
            };
        };
        "Xcode.AlertEvent.InstallSucceeds" =         {
            "Xcode.Alert.Dialog" =             {
                enabled = 1;
            };
        };
        "Xcode.AlertEvent.OpenGLCaptureCompletes" =         {
            "Xcode.Alert.ShowDebugger" =             {
                action = show;
                destination = workspace;
                enabled = 1;
                visibility = 0;
            };
            "Xcode.Alert.ShowEditor" =             {
                action = 0;
                enabled = 1;
                visibility = 2;
            };
            "Xcode.Alert.ShowNavigator" =             {
                enabled = 1;
                navigator = "Xcode.IDEKit.Navigator.Debug";
            };
        };
        "Xcode.AlertEvent.OpenGLCaptureStarts" =         {
            "Xcode.Alert.Dialog" =             {
            };
            enabled = 1;
        };
        "Xcode.AlertEvent.PlaygroundGeneratesOutput" =         {
            "Xcode.Alert.ShowDebugger" =             {
                action = show;
                destination = workspace;
                enabled = 1;
            };
        };
        "Xcode.AlertEvent.RunCompletes" =         {
            "Xcode.Alert.ShowDebugger" =             {
                action = hideIfNoOutput;
                destination = workspace;
                enabled = 1;
            };
        };
        "Xcode.AlertEvent.RunExitsUnexpectedly" =         {
        };
        "Xcode.AlertEvent.RunGeneratesOutput" =         {
            "Xcode.Alert.Bounce" =             {
                enabled = 0;
            };
            "Xcode.Alert.Dialog" =             {
                enabled = 0;
            };
            "Xcode.Alert.FirstIssue" =             {
                destination = firstIssue;
                enabled = 0;
            };
            "Xcode.Alert.RunScript" =             {
                enabled = 0;
            };
            "Xcode.Alert.ShowDebugger" =             {
                action = show;
                destination = workspace;
                enabled = 0;
                visibility = 0;
            };
            "Xcode.Alert.ShowEditor" =             {
                action = 0;
                enabled = 0;
                visibility = 0;
            };
            "Xcode.Alert.ShowNavigator" =             {
                action = 0;
                enabled = 0;
                navigator = "Xcode.IDEKit.Navigator.Structure";
            };
            "Xcode.Alert.ShowTab" =             {
                enabled = 0;
                tabTarget = 0;
            };
            "Xcode.Alert.ShowToolbar" =             {
                action = 0;
                enabled = 0;
            };
            "Xcode.Alert.ShowUtilityArea" =             {
                action = 0;
                enabled = 0;
            };
            "Xcode.Alert.Sound" =             {
                enabled = 0;
                soundPath = "/System/Library/Sounds/Sosumi.aiff";
            };
            "Xcode.Alert.Speech" =             {
                enabled = 0;
                voice = "com.apple.speech.synthesis.voice.Alex";
            };
        };
        "Xcode.AlertEvent.RunPauses" =         {
            "Xcode.Alert.Bounce" =             {
                enabled = 0;
            };
            "Xcode.Alert.Dialog" =             {
                enabled = 0;
            };
            "Xcode.Alert.FirstIssue" =             {
                destination = firstIssue;
                enabled = 0;
            };
            "Xcode.Alert.RunScript" =             {
                enabled = 0;
            };
            "Xcode.Alert.ShowDebugger" =             {
                action = show;
                destination = workspace;
                enabled = 0;
                visibility = 0;
            };
            "Xcode.Alert.ShowEditor" =             {
                action = 0;
                enabled = 0;
                visibility = 0;
            };
            "Xcode.Alert.ShowNavigator" =             {
                action = 0;
                enabled = 0;
                navigator = "Xcode.IDEKit.Navigator.Debug";
            };
            "Xcode.Alert.ShowTab" =             {
                enabled = 0;
                tabTarget = 0;
            };
            "Xcode.Alert.ShowToolbar" =             {
                action = 0;
                enabled = 0;
            };
            "Xcode.Alert.ShowUtilityArea" =             {
                action = 0;
                enabled = 0;
            };
            "Xcode.Alert.Sound" =             {
                enabled = 0;
                soundPath = "/System/Library/Sounds/Sosumi.aiff";
            };
            "Xcode.Alert.Speech" =             {
                enabled = 0;
                voice = "com.apple.speech.synthesis.voice.Alex";
            };
        };
        "Xcode.AlertEvent.RunStart" =         {
            "Xcode.Alert.ShowNavigator" =             {
                enabled = 0;
                navigator = "Xcode.IDEKit.Navigator.Debug";
            };
        };
        "Xcode.AlertEvent.SharingCompletes" =         {
            "Xcode.Alert.Dialog" =             {
                enabled = 1;
            };
        };
        "Xcode.AlertEvent.SharingFails" =         {
        };
        "Xcode.AlertEvent.SharingStart" =         {
        };
        "Xcode.AlertEvent.TestingFails" =         {
            "Xcode.Alert.Dialog" =             {
                enabled = 1;
            };
        };
        "Xcode.AlertEvent.TestingNewIssues" =         {
            "Xcode.Alert.Bounce" =             {
                enabled = 0;
            };
            "Xcode.Alert.Dialog" =             {
                enabled = 0;
            };
            "Xcode.Alert.FirstIssue" =             {
                destination = firstIssue;
                enabled = 0;
            };
            "Xcode.Alert.RunScript" =             {
                enabled = 0;
            };
            "Xcode.Alert.ShowDebugger" =             {
                action = show;
                destination = workspace;
                enabled = 0;
                visibility = 0;
            };
            "Xcode.Alert.ShowEditor" =             {
                action = 0;
                enabled = 0;
                visibility = 0;
            };
            "Xcode.Alert.ShowNavigator" =             {
                action = 0;
                enabled = 0;
                navigator = "Xcode.IDEKit.Navigator.Test";
            };
            "Xcode.Alert.ShowTab" =             {
                enabled = 0;
                tabTarget = 0;
            };
            "Xcode.Alert.ShowToolbar" =             {
                action = 0;
                enabled = 0;
            };
            "Xcode.Alert.ShowUtilityArea" =             {
                action = 0;
                enabled = 0;
            };
            "Xcode.Alert.Sound" =             {
                enabled = 0;
                soundPath = "/System/Library/Sounds/Sosumi.aiff";
            };
            "Xcode.Alert.Speech" =             {
                enabled = 0;
                voice = "com.apple.speech.synthesis.voice.Alex";
            };
        };
        "Xcode.AlertEvent.TestingPauses" =         {
            "Xcode.Alert.Bounce" =             {
                enabled = 0;
            };
            "Xcode.Alert.Dialog" =             {
                enabled = 0;
            };
            "Xcode.Alert.FirstIssue" =             {
                destination = firstIssue;
                enabled = 0;
            };
            "Xcode.Alert.RunScript" =             {
                enabled = 0;
            };
            "Xcode.Alert.ShowDebugger" =             {
                action = show;
                destination = workspace;
                enabled = 0;
                visibility = 0;
            };
            "Xcode.Alert.ShowEditor" =             {
                action = 0;
                enabled = 0;
                visibility = 0;
            };
            "Xcode.Alert.ShowNavigator" =             {
                action = 0;
                enabled = 0;
                navigator = "Xcode.IDEKit.Navigator.Debug";
            };
            "Xcode.Alert.ShowTab" =             {
                enabled = 0;
                tabTarget = 0;
            };
            "Xcode.Alert.ShowToolbar" =             {
                action = 0;
                enabled = 0;
            };
            "Xcode.Alert.ShowUtilityArea" =             {
                action = 0;
                enabled = 0;
            };
            "Xcode.Alert.Sound" =             {
                enabled = 0;
                soundPath = "/System/Library/Sounds/Sosumi.aiff";
            };
            "Xcode.Alert.Speech" =             {
                enabled = 0;
                voice = "com.apple.speech.synthesis.voice.Alex";
            };
        };
        "Xcode.AlertEvent.TestingStart" =         {
        };
        "Xcode.AlertEvent.TestingSucceeds" =         {
            "Xcode.Alert.Dialog" =             {
                enabled = 1;
            };
        };
        "Xcode.AlertEvent.WatchedIntegrationFinishes" =         {
            "Xcode.Alert.Dialog" =             {
                enabled = 1;
            };
        };
    };
}';

# To disable the purge policy [Options are aggressive, moderate, relaxed] (39508904 & 39444847)
echo "Configuring DVTTestDeviceClonePoolPurgePolicy"
defaults write com.apple.dt.Xcode DVTTestDeviceClonePoolPurgePolicy -string relaxed

# Set the max number of simulators we will boot (39509217 & 38960788)
echo "Configuring IDEParallelTestingWorkerCountOverride"
defaults write com.apple.dt.Xcode IDEParallelTestingWorkerCountOverride -int $simcount

# If Xcode crashes, we want to repopulate the pool with any clones that already exist, so we don’t boot again
echo "Configuring DVTTestDeviceClonePoolPopulateWithPreexistingClones"
defaults write com.apple.dt.Xcode DVTTestDeviceClonePoolPopulateWithPreexistingClones -bool YES

echo "Shutting down existing simulators"
xcrun simctl --set "/Users/$username/Library/Developer/XCTestDevices" shutdown all
rm -rf "/Users/$username/Library/Developer/XCTestDevices"

echo "Booting simulators"
XCODE_DEVELOPER_DIR="$xcode" ./sotubootsims --device-name "$simname" --count $simcount

echo "Listing simulators after boot"
xcrun simctl --set "/Users/$username/Library/Developer/XCTestDevices" list

echo "Done!"
