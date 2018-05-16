#! /bin/sh

username=$(whoami)
echo "Username is $username"

simcount=4
echo "Simulator count for demo is $simcount"

simname="iPhone 8"
echo "Target simulator for the demo is $simname"

xcode=$(xcode-select -p)
echo "Selected Xcode path is $xcode"

echo "Closing all instances of Xcode and Simulator"
killall Xcode
killall Simulator

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

echo "Booting simulators"
XCODE_DEVELOPER_DIR="$xcode" ./sotubootsims --device-name "$simname" --count $simcount

echo "Listing simulators after boot"
xcrun simctl --set "/Users/$username/Library/Developer/XCTestDevices" list

echo "Setting test reports defaults"
defaults write com.apple.dt.Xcode IDETestReport_ShowFailedTests -bool NO
defaults write com.apple.dt.Xcode IDETestReport_ShowPassedAndFailed -bool YES

defaults write com.apple.dt.Xcode "NSTableView Columns v2 TestReportv2" -data "62706c6973743030d40102030405064344582476657273696f6e58246f626a65637473592461726368697665725424746f7012000186a0af10110708101b1c1d1e1f2021273132333d3e3f55246e756c6cd2090a0b0f5a4e532e6f626a656374735624636c617373a30c0d0e8002800a800d8010d311090a12161a574e532e6b657973a3131415800380048005a317181980068007800880095a4964656e7469666965725557696474685648696464656e5c537461747573436f6c756d6e23404380000000000008d2222324255a24636c6173736e616d655824636c61737365735c4e5344696374696f6e617279a22426584e534f626a656374d311090a282c1aa3131415800380048005a32d2e19800b800c800880095b5469746c65436f6c756d6e234088a80000000000d311090a34381aa3131415800380048005a3393a19800e800f80088009584475726174696f6e23404e000000000000d2222340415e4e534d757461626c654172726179a3404226574e5341727261795f100f4e534b657965644172636869766572d14546554172726179800100080011001a0023002d00320037004b0051005600610068006c006e007000720074007b008300870089008b008d0091009300950097009900a400aa00b100be00c700c800cd00d800e100ee00f100fa0101010501070109010b010f01110113011501170123012c013301370139013b013d014101430145014701490152015b0160016f0173017b018d019001960000000000000201000000000000004700000000000000000000000000000198"

defaults write com.apple.dt.Xcode "NSTableView Sort Ordering v2 TestReportv2" -data "62706c6973743030d40102030405061415582476657273696f6e58246f626a65637473592461726368697665725424746f7012000186a0a307080d55246e756c6cd2090a0b0c5a4e532e6f626a656374735624636c617373a08002d20e0f10115a24636c6173736e616d655824636c61737365735e4e534d757461626c654172726179a3101213574e534172726179584e534f626a6563745f100f4e534b657965644172636869766572d11617554172726179800108111a232d32373b41465158595b606b7483878f98aaadb300000000000001010000000000000018000000000000000000000000000000b5"

defaults write com.apple.dt.Xcode "NSTableView Supports v2 TestReportv2" -bool YES

defaults write com.apple.dock "expose-group-apps" -bool YES

echo "Done!"
