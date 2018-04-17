//
//  Inspector.swift
//  Solar System Mac
//
//  Created by Sebastian Fischer on 14.04.18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Cocoa
import SceneKit

class Inspector: NSViewController {
    var sceneView: SCNView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Observe effective appearance changes
        addObserver(self, forKeyPath: #keyPath(view.effectiveAppearance), options: [.new], context: nil)
        
        // TODO: Replace image view with 3D scene view
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if (keyPath == #keyPath(view.effectiveAppearance)) {
            effectiveAppearanceDidChange()
        }
    }
    
    func effectiveAppearanceDidChange() {
        let effectiveAppearanceIsDark = view.effectiveAppearance._isDark
        
        if let astronomicalObjectNode = sceneView?.scene?.rootNode.childNode(withName: "astronomicalObject", recursively: true) {
            let textureName = effectiveAppearanceIsDark ? "EarthNightLights" : "Earth"
            let image = NSImage(named: NSImage.Name(rawValue: textureName))
            astronomicalObjectNode.geometry?.firstMaterial?.diffuse.contents = image
        }
    }
}

extension NSAppearance {
    var _isDark: Bool {
        return name.rawValue.contains("Dark")
    }
}
