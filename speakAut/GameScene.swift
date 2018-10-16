//
//  GameScene.swift
//  speakAut
//
//  Created by Beatriz Melo Mousinho Magalhães on 31/08/18.
//  Copyright © 2018 Beatriz Melo Mousinho Magalhães. All rights reserved.
//

import SpriteKit

private let cardNodeName = "movable"

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let background = SKSpriteNode(imageNamed: "backgroundImage")
    var selectedNode = SKSpriteNode()
    
//    private let cardCategory: UInt32 = 1 << 0
//    private let gapCategory: UInt32 = 1 << 1
    
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        self.scaleMode = .resizeFill
        
        addBackground()
        addCards()
        
//        self.card.physicsBody?.contactTestBitMask = cardCategory
//        self.gap.physicsBody?.contactTestBitMask = gapCategory
     
    }

    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = self.atPoint(location)
            
            if (touchedNode.name?.starts(with: "movable"))! {
                touchedNode.position.x = location.x
                touchedNode.position.y = location.y
            }
            
        }
    }
    
    func addCards() {
        let imageNames = ["card", "card2"]
        
        print(imageNames.count)
        
        for i in 0..<imageNames.count {
            let imageName = imageNames[i]
            
            let sprite = SKSpriteNode(imageNamed: imageName)
            sprite.name = cardNodeName
            
            if i == 0 {
                sprite.position = CGPoint(x: 200.0, y: 0.0)
                
            } else {
                sprite.position = CGPoint(x: -150.0, y: 0.0)
            }
            sprite.zPosition = 5
            print(sprite.position)
            background.addChild(sprite)
        }
        
    }
    
    func addBackground () {
        self.background.name = "background"
        self.addChild(background)
    }
    
 
//    func didBegin(_ contact: SKPhysicsContact) {
//        print("didBeginContact entered for \(String(describing: contact.bodyA.node!.name)) and \(String(describing: contact.bodyB.node!.name))")
//
//        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
//
//        switch contactMask {
//        case cardCategory | gapCategory:
//            print("card touched gap.")
//            let bulletNode = contact.bodyA.categoryBitMask == gapCategory ? contact.bodyA.node : contact.bodyB.node
//        default:
//            print("Some other contact occurred")
//        }
//    }
    
    
   
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
}
