//
//  GameScene.swift
//  speakAut
//
//  Created by Beatriz Melo Mousinho Magalhães on 31/08/18.
//  Copyright © 2018 Beatriz Melo Mousinho Magalhães. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    private var background = SKSpriteNode()
    private var selectedNode = SKSpriteNode()

    override func didMove(to view: SKView) {
        self.scaleMode = .resizeFill
        
        addBackground()
        addCardsAndGaps()
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
        self.background.name = "background"
        addChild(background)
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
}

