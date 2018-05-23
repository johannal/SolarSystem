//
//  AppDelegate.swift
//  Solar System Mac
//
//  Copyright © 2018 Apple. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    override init() {
        super.init()
        _updateDefaults()
    }

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
            //solarSystemSceneVC.refreshPlanetsAndNews()
            solarSystemSceneVC.toggleNewsFeedUpdates(sender)
        }
    }
    
    func _updateDefaults() {
        // Default news feed update setting
        var wantsNewsFeedUpdates = false
        if let displayLinkAnimationsEnVar = ProcessInfo.processInfo.environment["AutomaticNewsFeedUpdates"] {
            let enVar: NSString = displayLinkAnimationsEnVar as NSString
            wantsNewsFeedUpdates = enVar.boolValue
        }
        SceneViewController.wantsAutomaticNewsFeedUpdates = wantsNewsFeedUpdates
        
        // Default for display link animations
        var wantsDisplayLinkAnimations = false
        if let displayLinkAnimationsEnVar = ProcessInfo.processInfo.environment["DisplayLinkAnimations"] {
            let enVar: NSString = displayLinkAnimationsEnVar as NSString
            wantsDisplayLinkAnimations = enVar.boolValue
        }
        SceneAnimator.wantsDisplayLinkAnimations = wantsDisplayLinkAnimations
    }
}
