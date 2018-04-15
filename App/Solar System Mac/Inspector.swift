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
    
    @IBOutlet weak var sceneView: SCNView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    // TODO: Switch between earth and earth at night texture based on appearance
    func effectiveAppearanceDidChange() {
        if let astronomicalObjectNode = sceneView.scene?.rootNode.childNode(withName: "astronomicalObject", recursively: true) {
            let textureName = "Earth" // EarthNightLights
            let image = NSImage(named: NSImage.Name(rawValue: textureName))
            astronomicalObjectNode.geometry?.firstMaterial?.diffuse.contents = image
        }
    }
    
}
