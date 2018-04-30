//
//  Inspector.swift
//  Solar System Mac
//
//  Copyright © 2018 Apple. All rights reserved.
//

import Cocoa
import SceneKit

class SolarSceneViewAppearanceManager: NSObject {
    private let sceneView: SCNView

    private var observation: NSKeyValueObservation?

    init(sceneView: SCNView) {
        self.sceneView = sceneView
        super.init()
        self.observation = sceneView.observe(\.effectiveAppearance) { [weak self] (_, _) in
            self?.effectiveAppearanceDidChange()
        }
    }

    deinit {
        observation?.invalidate()
    }
    
    private func effectiveAppearanceDidChange() {
        let effectiveAppearanceIsDark = sceneView.effectiveAppearance._isDark
        
        if let astronomicalObjectNode = sceneView.scene?.rootNode.childNode(withName: "astronomicalObject", recursively: true) {
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
