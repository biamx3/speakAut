//
//  GameScene.swift
//  speakAut
//
//  Created by Beatriz Melo Mousinho Magalhães on 31/08/18.
//  Copyright © 2018 Beatriz Melo Mousinho Magalhães. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private let cardNodeName = "card"
    private let gapNodeName = "gap"
    
    var background = SKSpriteNode()
    var selectedNode = SKSpriteNode()
    
    private let cardCategory: UInt32 = 1 << 0
    private let gapCategory: UInt32 = 1 << 1
    
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        self.scaleMode = .resizeFill
        
        addBackground()
        

       // addGaps()
        addCards()
        //setUpForCollisions()
        printAllNodes(tab: "", node: self.scene!)

    }
    
    
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for touch in touches {
//            let location = touch.location(in: self)
//            let touchedNode = self.atPoint(location)
//
//            print(touchedNode.name, "was touched")
//
//            if (touchedNode.name?.starts(with: "cardChild"))! {
//                touchedNode.parent!.position.x = location.x
//                touchedNode.parent!.position.y = location.y
//            }
//
//            else if (touchedNode.name?.starts(with: "cardParent"))! {
//                touchedNode.position.x = location.x
//                touchedNode.position.y = location.y
//            }
//        }
//    }
//
    func printAllNodes(tab:String, node:SKNode) {
        let aTab = tab + "  "
        for child in node.children {
            print(aTab, child.name ?? "--- sem nome ---")
            printAllNodes(tab: aTab, node: child)

        }
    }
    
    func addCards() {
        let dao = DAO()
        let character = dao.createCharacter()
        let sentence = character.sentenceArray[0]

        for i in 0 ... (sentence.cardArray.count - 1){
            let cardModel = sentence.cardArray[i]
            let card = CardViewModel(cardModel: cardModel)
           // let zPosition = CGFloat(i + 7)
           // card.zPosition = zPosition
            
            switch i {
            case 0:
                card.position = CGPoint(x: 180.0, y: 170.0)
            case 1:
                card.position = CGPoint(x: -150.0, y: 170.0)

            default:
                break
            }
            self.background.addChild(card)
        }
    }
    
/*
            sprite.physicsBody?.categoryBitMask = cardCategory
            sprite.physicsBody?.contactTestBitMask = gapCategory
            sprite.physicsBody?.collisionBitMask = 0
            background.addChild(sprite)
*/
    
    func addGaps() {
        
        let numberOfGaps = 3
        let gapImageName = "gap"
        
        for i in 0...numberOfGaps {
            
            let sprite = SKSpriteNode(imageNamed: "gap")
            sprite.name = gapImageName
            
            if i == 0 {
                sprite.position = CGPoint(x: 180.0, y: -160.0)
                
            } else {
                sprite.position = CGPoint(x: -150.0, y: -160.0)
            }
            sprite.zPosition = 4
            sprite.physicsBody?.usesPreciseCollisionDetection = true
            sprite.physicsBody = SKPhysicsBody.init(rectangleOf: CGSize(width: sprite.size.width, height: sprite.size.height))
            sprite.physicsBody?.categoryBitMask = gapCategory
            sprite.physicsBody?.contactTestBitMask = cardCategory
            sprite.physicsBody?.collisionBitMask = 0
            sprite.physicsBody?.isDynamic = false
            background.addChild(sprite)
        }
    }
    
    func addBackground () {
        self.background = self.childNode(withName: "backgroundImage") as! SKSpriteNode
        self.background.isUserInteractionEnabled = false
        self.background.name = "background"
    }
    
    func setUpForCollisions () {
        for child in (self.scene?.children)! {
            if (child.name?.starts(with: "card"))! {
                child.physicsBody?.categoryBitMask = gapCategory
                child.physicsBody?.contactTestBitMask = cardCategory
                child.physicsBody?.collisionBitMask = 0
            }
            if (child.name?.starts(with: "gap"))! {
                child.physicsBody?.categoryBitMask = cardCategory
                child.physicsBody?.contactTestBitMask = gapCategory
                child.physicsBody?.collisionBitMask = 0
            }
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        print("collided")
        print("didBeginContact entered for \(String(describing: contact.bodyA.node!.name)) and \(String(describing: contact.bodyB.node!.name))")
        
        let card = contact.bodyB.node!
        let gap = contact.bodyA.node!
        
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask

        switch contactMask {
        case cardCategory | gapCategory:
            print("card touched gap.")
            let moveToGap = SKAction.move(to: gap.position, duration: 0.5)
            card.run(moveToGap)
            contact.bodyB.node!.isUserInteractionEnabled = false

        default:
            print("Some other contact occurred")
            contact.bodyA.node!.position = contact.bodyB.node!.position
        }
    }
    
    
   
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
}

