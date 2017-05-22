//
//  GravitySimulatorScene.swift
//  Science
//
//  Created by Sebastian Fischer on 21.05.17.
//  Copyright © 2017 Apple. All rights reserved.
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
        if let leftWall = childNode(withName: "leftWall") as? SKSpriteNode {
            leftWall.size = CGSize.init(width: wallThickness, height: size.height)
            leftWall.position = CGPoint.init(x: -size.width/2.0 - wallThickness/2.0, y: 0)
            leftWall.updateStaticPhysicsBody()
        }
        
        if let rightWall = childNode(withName: "rightWall") as? SKSpriteNode {
            rightWall.size = CGSize.init(width: wallThickness, height: size.height)
            rightWall.position = CGPoint.init(x: size.width/2.0 + wallThickness/2.0, y: 0)
            rightWall.updateStaticPhysicsBody()
        }
        
        let horizontalWallLength = size.width + wallThickness * 2.0
        if let topWall = childNode(withName: "topWall") as? SKSpriteNode {
            topWall.size = CGSize.init(width: horizontalWallLength, height: wallThickness)
            topWall.position = CGPoint.init(x: 0, y: size.height/2.0 + wallThickness/2.0)
            topWall.updateStaticPhysicsBody()
        }
        
        if let bottomWall = childNode(withName: "bottomWall") as? SKSpriteNode {
            bottomWall.size = CGSize.init(width: horizontalWallLength, height: wallThickness)
            bottomWall.position = CGPoint.init(x: 0, y: -size.height/2.0 - wallThickness/2.0)
            bottomWall.updateStaticPhysicsBody()
        }
        
        if let backgroundNode = self.childNode(withName: "backgroundNode") as? SKSpriteNode {
            backgroundNode.size = CGSize.init(width: size.width, height: size.width/4*3)
            backgroundNode.position = .zero
        }
    }
    
    func simulateZeroGravity() {
        if let elementHostNode = childNode(withName: "ElementHost") {
            for elementNode in elementHostNode.children {
                if let node = elementNode as? SKSpriteNode {
                    node.physicsBody?.affectedByGravity = true
                    node.physicsBody?.isDynamic = true
                    node.physicsBody?.allowsRotation = true
                    node.physicsBody?.pinned = false
                }
            }
        }
        
        if let noiseFieldHostNode = childNode(withName: "noiseFieldHostNode") {
            for noiseFieldNode in noiseFieldHostNode.children {
                if let node = noiseFieldNode as? SKFieldNode {
                    node.isEnabled = true
                }
            }
        }
        
        self.physicsWorld.gravity = CGVector.init(dx: 0.0, dy: 0.0)
    }
    
    func activateGravity(_ gravity: Double) {
        if let noiseFieldHostNode = childNode(withName: "noiseFieldHostNode") {
            for noiseFieldNode in noiseFieldHostNode.children {
                if let node = noiseFieldNode as? SKFieldNode {
                    node.isEnabled = false
                }
            }
        }
        
        self.physicsWorld.gravity = CGVector.init(dx: 0.0, dy: gravity)
    }
}
