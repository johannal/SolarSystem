//
//  ParticleSystemsManager.swift
//  Solar System Mac
//
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
import SceneKit


/// Object that manager particle systems associated with scene over time. Is responsible for managing and animating them.
final class ParticleSystemsAnimator {

    private let scene: SCNScene

    init(scene: SCNScene) {
        self.scene = scene
        animateParticleSystemsOverTime()
    }

    private func animateParticleSystemsOverTime() {

    }
}
