//
//  AppDelegate.swift
//  Solar System Mac
//
//  Copyright © 2018 Apple. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBAction func refreshClicked(_ sender: Any) {
        let windowController = NSApplication.shared.mainWindow?.windowController
        let viewController = windowController?.contentViewController

        if let solarSystemSceneVC = viewController as? SolarSystemSceneViewController {
            solarSystemSceneVC.refreshPlanetsAndNews()
        }
    }

}

