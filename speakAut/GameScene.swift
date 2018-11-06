//
//  GameScene.swift
//  speakAut
//
//  Created by Beatriz Melo Mousinho Magalhães on 31/08/18.
//  Copyright © 2018 Beatriz Melo Mousinho Magalhães. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private var background = SKSpriteNode()
    private var selectedNode = SKSpriteNode()

    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        self.scaleMode = .resizeFill
        
        addBackground()
        addCardsAndGaps()
        //setUpForCollisions()
        printAllNodes(tab: "", node: self.scene!)
    }
    
    func addCardsAndGaps(){
        let dao = DAO()
        let character = dao.createCharacter()
        let sentence = character.sentenceArray[0]
        let cardSet = sentence.cardArray
        
        let cardSetViewModel = CardSetViewModel(cardSet: cardSet)
        self.addChild(cardSetViewModel)
    }
    
    func printAllNodes(tab:String, node:SKNode) {
        let aTab = tab + "  "
        for child in node.children {
            print(aTab, child.name ?? "--- sem nome ---")
            printAllNodes(tab: aTab, node: child)

        }
    }
    
    func addBackground () {
        self.background = SKSpriteNode(texture: SKTexture(imageNamed: "backgroundImage"), color: .blue, size: self.scene?.size ?? SKTexture(imageNamed: "backgroundImage").size())
        self.background.position = CGPoint.zero
        self.background.isUserInteractionEnabled = false
        self.background.physicsBody? = SKPhysicsBody(rectangleOf: self.background.size)
        self.background.physicsBody?.affectedByGravity = false
        self.background.physicsBody?.isDynamic = false 
        self.background.name = "background"
        addChild(background)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        print("didBeginContact entered for \(String(describing: contact.bodyA.node!.name)) and \(String(describing: contact.bodyB.node!.name))")
        
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
            
        case UInt32.cardCategory | UInt32.gapCategory :
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

