//
//  AppDelegate.swift
//  Solar System Mac
//
//  Copyright © 2018 Apple. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        _showDockIconIfNecessary()
    }
    
    fileprivate func _showDockIconIfNecessary() {
        if wantsDockIcon {
            NSApp.setActivationPolicy(.regular)
        }
    }
    
    var wantsDockIcon: Bool {
        let hideDockIcon = UserDefaults.standard.bool(forKey: "HideDockIcon")
        return !hideDockIcon
    }
    
    @IBAction func refreshClicked(_ sender: Any) {
        let windowController = NSApplication.shared.mainWindow?.windowController
        let viewController = windowController?.contentViewController

        if let solarSystemSceneVC = viewController as? SceneViewController {
            solarSystemSceneVC.refreshPlanetsAndNews()
        }
    }

}
