//
//  GameScene.swift
//  speakAut
//
//  Created by Beatriz Melo Mousinho Magalhães on 31/08/18.
//  Copyright © 2018 Beatriz Melo Mousinho Magalhães. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var background = SKSpriteNode()
    var selectedNode = SKSpriteNode()
    
    private let cardCategory: UInt32 = 1 << 0
    private let gapCategory: UInt32 = 1 << 1
    private let radiusCategory: UInt32 = 1 << 2
    
    private var cardArray = [CardViewModel]()
    
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        self.scaleMode = .resizeFill
        
//        addBackground()
        addGaps()
      //  addCards()
        //setUpForCollisions()
        printAllNodes(tab: "", node: self.scene!)
    }
    
    func addGaps(){
        let gap = GapViewModel(numberOfGaps: 2)
        self.addChild(gap)
    }
    
    func printAllNodes(tab:String, node:SKNode) {
        let aTab = tab + "  "
        for child in node.children {
            print(aTab, child.name ?? "--- sem nome ---")
            printAllNodes(tab: aTab, node: child)

        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touches Ended")
    }
    
    func addCards() {
        let dao = DAO()
        let character = dao.createCharacter()
        let sentence = character.sentenceArray[0]

        for i in 0 ... (sentence.cardArray.count - 1){
            let cardModel = sentence.cardArray[i]
            let card = CardViewModel(cardModel: cardModel)

            
            switch i {
            case 0:
                card.position = CGPoint(x: 180.0, y: 170.0)
            case 1:
                card.position = CGPoint(x: -150.0, y: 170.0)

            default:
                break
            }
            card.name = "card"
            card.physicsBody?.categoryBitMask = cardCategory
            card.physicsBody?.contactTestBitMask = radiusCategory
            card.physicsBody?.collisionBitMask = 0
            cardArray.append(card)
            self.background.addChild(card)
        }
    }
    
    func drawCircle(withCenter: CGPoint){
        
        let circle = SKShapeNode(circleOfRadius: 40 ) // Size of Circle
        circle.position = withCenter
        circle.glowWidth = 1.0
        circle.fillColor = SKColor.orange
        circle.zPosition = 10
        circle.name = "radius"
        circle.physicsBody?.usesPreciseCollisionDetection = true
        circle.physicsBody = SKPhysicsBody.init(circleOfRadius: 40)
        circle.physicsBody?.categoryBitMask = radiusCategory
        circle.physicsBody?.contactTestBitMask = cardCategory
        circle.physicsBody?.collisionBitMask = 0
        circle.physicsBody?.isDynamic = false
        self.addChild(circle)
    }
    
    func addBackground () {
        self.background = self.childNode(withName: "backgroundImage") as! SKSpriteNode
        self.background.isUserInteractionEnabled = false
        self.background.name = "background"
    }
    
    func setUpForCollisions () {
        for child in (self.scene?.children)! {
            child.physicsBody = SKPhysicsBody.init(rectangleOf: CGSize.card)
            child.physicsBody?.usesPreciseCollisionDetection = true
            if (child.name?.starts(with: "card"))! {
                child.physicsBody?.categoryBitMask = cardCategory
                child.physicsBody?.contactTestBitMask = gapCategory
                child.physicsBody?.collisionBitMask = 0
                child.physicsBody?.isDynamic = true
            }
            if (child.name?.starts(with: "gap"))! {
                child.physicsBody?.categoryBitMask = gapCategory
                child.physicsBody?.contactTestBitMask = cardCategory
                child.physicsBody?.collisionBitMask = 0
                child.physicsBody?.isDynamic = false
            }
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
  //      print("didBeginContact entered for \(String(describing: contact.bodyA.node!.name)) and \(String(describing: contact.bodyB.node!.name))")
        
        print(contact.bodyA.node!.name)
        
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        guard let card = contact.bodyB.node else {return}
        guard let gap = contact.bodyA.node else {return}

//        if contact.bodyA.categoryBitMask == cardCategory || contact.bodyB.categoryBitMask == gapCategory {
//            card.run(moveToGap)
//        }
        
      //  if let contactMask = cardCategory | gapCategory {
            
//            card.run(moveToGap)
//
//
        switch contactMask {
            
        case cardCategory | gapCategory :
            let gapPosition = gap.position
            let moveToGap = SKAction.move(to: gapPosition, duration: 0.5)
            card.run(moveToGap)
            contact.bodyB.node!.isUserInteractionEnabled = false
//        case cardCategory | radiusCategory :
//            guard let card = contact.bodyA.node else {return}
//            card.run(moveToGap)
//            //  contact.bodyB.node!.isUserInteractionEnabled = false

        default:
            print("failed")
        }
    }


    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
}

