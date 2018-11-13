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
        self.isUserInteractionEnabled = true
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
    
//    override func update(_ currentTime: TimeInterval) {
        //Filter all nodes in scene to identify gaps and cards
//        let brothers = self.allDescendants()
//        let cards = brothers.filter {($0.name?.starts(with: "card") ?? false)}
//        let gaps = brothers.filter {($0.name?.starts(with: "gap") ?? false)}
//        let cardArray = cards as! [CardViewModel]
//
//        for i in 0...cardArray.count - 1{
//            let card = cardArray[i]
//            let index = i
//            let lastItem = cardArray.last
//            let lastIndex = cardArray.index(of: lastItem ?? card)
//
//            if index != lastIndex {
//                if card.position == cardArray[lastIndex ?? 0].position {
//                    card.run(SKAction.move(by: CGVector(dx: 0, dy: 180), duration: 0.5))
//                }
//            }
//        }
//
//    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(type(of:self), #function)
    }
}



