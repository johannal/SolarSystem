//
//  GravitySimulatorScene.swift
//  Solar System
//
//  Copyright © 2018 Apple Inc. All rights reserved.
//

let wallThickness: CGFloat = 10.0

import SpriteKit

extension SKSpriteNode {
    
    func updateStaticPhysicsBody() {
        let body = SKPhysicsBody(rectangleOf: size)
        body.affectedByGravity = false
        body.pinned = true
        body.allowsRotation = false
        physicsBody = body
    }
    
}

class GravitySimulatorScene: SKScene {
    
    override func didChangeSize(_ oldSize: CGSize) {
        // Update positioning of walls
        if let leftWall = childNode(withName: "Left Edge") as? SKSpriteNode {
            leftWall.size = CGSize.init(width: wallThickness, height: size.height)
            leftWall.position = CGPoint.init(x: -size.width/2.0 - wallThickness/2.0, y: 0)
            leftWall.updateStaticPhysicsBody()
        }
        
        if let rightWall = childNode(withName: "Right Edge") as? SKSpriteNode {
            rightWall.size = CGSize.init(width: wallThickness, height: size.height)
            rightWall.position = CGPoint.init(x: size.width/2.0 + wallThickness/2.0, y: 0)
            rightWall.updateStaticPhysicsBody()
        }
        
        let horizontalWallLength = size.width + wallThickness * 2.0
        if let topWall = childNode(withName: "Ceiling") as? SKSpriteNode {
            topWall.size = CGSize.init(width: horizontalWallLength, height: wallThickness)
            topWall.position = CGPoint.init(x: 0, y: size.height/2.0 + wallThickness/2.0)
            topWall.updateStaticPhysicsBody()
        }
        
        if let bottomWall = childNode(withName: "Floor") as? SKSpriteNode {
            bottomWall.size = CGSize.init(width: horizontalWallLength, height: wallThickness)
            bottomWall.position = CGPoint.init(x: 0, y: -size.height/2.0 - wallThickness/2.0)
            bottomWall.updateStaticPhysicsBody()
        }
        
        if let backgroundNode = self.childNode(withName: "Background") as? SKSpriteNode {
            backgroundNode.size = CGSize.init(width: size.height/4*3, height: size.height)
            backgroundNode.position = .zero
        }
    }
    
    func simulateZeroGravity() {
        if let elementHostNode = childNode(withName: "Element Host") {
            for elementNode in elementHostNode.children {
                if let node = elementNode as? SKSpriteNode {
                    node.physicsBody?.affectedByGravity = true
                    node.physicsBody?.isDynamic = true
                    node.physicsBody?.allowsRotation = true
                    node.physicsBody?.pinned = false
                }
            }
        }
        
        if let noiseFieldHostNode = childNode(withName: "Noise Field Host") {
            for noiseFieldNode in noiseFieldHostNode.children {
                if let node = noiseFieldNode as? SKFieldNode {
                    node.isEnabled = true
                }
            }
        }
        
        self.physicsWorld.gravity = CGVector.init(dx: 0.0, dy: 0.0)
    }
    
    func activateGravity(_ gravity: Double) {
        if let noiseFieldHostNode = childNode(withName: "Noise Field Host") {
            for noiseFieldNode in noiseFieldHostNode.children {
                if let node = noiseFieldNode as? SKFieldNode {
                    node.isEnabled = false
                }
            }
        }
        
        self.physicsWorld.gravity = CGVector.init(dx: 0.0, dy: gravity)
        
        // Pause the scene after a few seconds to avoid micro movements
        DispatchQueue.main.asyncAfter(deadline: .now() + 8.0) {
            self.isPaused = true
        }
    }
}
