//
//  SolarSystemSceneWindowController.swift
//  Solar System Mac
//
//  Copyright © 2018 Apple. All rights reserved.
//

import AppKit

final class SceneWindowController: NSWindowController {

    @IBAction func refreshClicked(sender: Any) {
        if let solarSystemSceneVC = contentViewController as? SceneViewController {
            solarSystemSceneVC.refreshPlanetsAndNews()
        }
    }
}
