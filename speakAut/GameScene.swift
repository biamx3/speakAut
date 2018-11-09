//
//  GameScene.swift
//  speakAut
//
//  Created by Beatriz Melo Mousinho Magalhães on 31/08/18.
//  Copyright © 2018 Beatriz Melo Mousinho Magalhães. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {

    override func didMove(to view: SKView) {
        self.scaleMode = .resizeFill
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
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
}

