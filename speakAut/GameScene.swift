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
    
    //Prints all nodes in node tree
    func printAllNodes(tab:String, node:SKNode) {
        let aTab = tab + "  "
        for child in node.children {
            print(aTab, child.name ?? "--- sem nome ---")
            printAllNodes(tab: aTab, node: child)

        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        //Filter all nodes in scene to identify gaps and cards
        let brothers = self.allDescendants()
        let cards = brothers.filter {($0.name?.starts(with: "card") ?? false)}
        let cardArray = cards as! [CardViewModel]

        //Compare each card's position with the last card in the array
        for i in 0...cardArray.count - 1{
            let card = cardArray[i]
            let index = i
            let lastItem = cardArray.last
            let lastIndex = cardArray.index(of: lastItem ?? card)
            let nextCard = cardArray[lastIndex ?? 0]
            let removeCardFromGap = SKAction.move(by: CGVector(dx: 0, dy: 180), duration: 0.2)
            removeCardFromGap.timingMode = .easeOut
            
            //If two cards have the same position, remove the card with the lowest zPosition from the gap
            if index != lastIndex && card.position == nextCard.position   {
                if card.zPosition < nextCard.zPosition {
                    card.run(removeCardFromGap)
                } else {
                    nextCard.run(removeCardFromGap)
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(type(of:self), #function)
    }
}



