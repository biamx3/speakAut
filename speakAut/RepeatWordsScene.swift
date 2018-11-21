//
//  RepeatWordsScene.swift
//  speakAut
//
//  Created by Beatriz Melo Mousinho Magalhães on 19/11/18.
//  Copyright © 2018 Beatriz Melo Mousinho Magalhães. All rights reserved.
//

import UIKit
import SpriteKit

class RepeatWordsScene: SKScene {
    
    var cardSet = [Card]()
    
    override func didMove(to view: SKView) {

        self.scaleMode = .resizeFill
        self.isUserInteractionEnabled = true
       // addBackButton()
        addBackground()
        addCards()
        setUpInstructionsLabel()
        printAllNodes(tab: "", node: self.scene!)
    }
    
    func addCards(){
        let sceneSize = UIScreen.main.bounds.size
        let cardSetViewModel = CardSetViewModel(cardSet: self.cardSet, type: .RepeatWordsScene)
        cardSetViewModel.position = CGPoint(x: sceneSize.width/2, y: sceneSize.height/2)
        print("cardSetViewModel anchorpoint: ", cardSetViewModel.anchorPoint)
        cardSetViewModel.zPosition = 3
        print("cardSetViewModel position:" , cardSetViewModel.position)
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
    
    func setUpInstructionsLabel() {
        let sceneSize = self.frame.size
        let instructionsLabel = SKLabelNode(text: "Agora, toque nas cartas na ordem certa e repita as palavras!")
        instructionsLabel.name = "instructionsLabel"
        instructionsLabel.fontSize = 32
        instructionsLabel.fontColor = UIColor.greyishBrown
        instructionsLabel.zPosition = 15
        instructionsLabel.position = CGPoint(x: sceneSize.width/2, y: sceneSize.height - 100)
        
        self.addChild(instructionsLabel)
    }
    
    func addBackground(){
        let sceneSize = UIScreen.main.bounds.size
        let backgroundTexture = SKTexture(imageNamed: "backgroundImage")
        let backgroundNode = SKSpriteNode(texture: backgroundTexture, color: .clear, size: backgroundTexture.size())
        backgroundNode.zPosition = 0
        backgroundNode.position = CGPoint(x: sceneSize.width/2, y: sceneSize.height/2)
        self.addChild(backgroundNode)
    }

    func addBackButton() {
        let sceneSize = UIScreen.main.bounds.size
        let backButtonTexture = SKTexture(imageNamed: "backButton")
        let touchArea = SKShapeNode(circleOfRadius: backButtonTexture.size().width*1.3)
        touchArea.strokeColor = .clear
        touchArea.name = "backButton"
        touchArea.position = CGPoint(x: -sceneSize.width/5 , y: sceneSize.height/2.4)
        print("touch area position: ", touchArea.position)
        let backButton = SKSpriteNode(texture: backButtonTexture, color: .clear, size: backButtonTexture.size())
        backButton.name = "backButton"
        touchArea.addChild(backButton)
        touchArea.zPosition = 4
        self.addChild(touchArea)
    }
    
    override func update(_ currentTime: TimeInterval) {
        //Filter all nodes in scene to identify gaps and cards
        let brothers = self.allDescendants()
        let cards = brothers.filter {($0.name?.starts(with: "card") ?? false)}
        let cardArray = cards as! [CardViewModel]
        var bigCardArray: [CardViewModel] = []
        

        for i in 0...cardArray.count - 1{
            let card = cardArray[i]
            let index = i
            
            if card.size.width > CGSize.card.width {
                if cardArray.isOrderedInXWithScale {
                    print("is ordered: ", cardArray.isOrderedInXWithScale)
                } else {
                    print("is not ordered", cardArray.isOrderedInXWithScale)
                }
            
//            if card.size.width > CGSize.card.width {
//             bigCardArray.append(card)
//                if bigCardArray.isOrderedInXWithScale && bigCardArray.count == cardArray.count {
//                    print("correct")
//                } else {
//                    print("incorrect")
//                }
//            }
//            if card.size.width <= CGSize.card.width && bigCardArray.contains(card) {
//                bigCardArray.remove(at: index)
//            }

            
//            if bigCardArray.isOrderedInXWithScale {
//                if bigCardArray.count == cardArray.count {
//                    print("correct")
//                }
//            } else {
//                print("incorrect")
            }
        }
    }
}
