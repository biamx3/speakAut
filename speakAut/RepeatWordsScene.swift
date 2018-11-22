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
        instructionsLabel.preferredMaxLayoutWidth = sceneSize.width*0.8
        instructionsLabel.fontName = "PeachyKeenJF"
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
        
//        var bigCards: [CardViewModel] = []
//        
//        
//        //Add cards that are big to bigCards array
//        for card in cardArray {
//            let index = cardArray.index(of: card)
//            let lastIndex = cardArray.endIndex
//            
//            if card.size.width > CGSize.card.width && !bigCards.contains(card) {
//                bigCards.append(card)
//                print("big cards ", bigCards)
//            }
//            
//            if card.size.width == CGSize.card.width && bigCards.contains(card) {
//                bigCards.remove(at: index ?? 0)
//            }
//            
//            
//            if bigCards.count == cardArray.count {
//                if bigCards == cardArray {
//                    print("success")
//                } else {
//                    print("failure")
//                }
//            }
            
            //Check if bigCards array is in order
//            if bigCards.count == cardArray.count {
//                for card in bigCards {
//                    let cardIndex = bigCards.index(of: card)
//                    let previousCardIndex = bigCards.index(before: cardIndex ?? 1)
//                    let previousCard = bigCards[previousCardIndex]
//
//                    if card != bigCards[0] {
//                        if card.cardModel.index > previousCard.cardModel.index {
//                        print("correct order of bigCards")
//                        } else {
//                        print("incorrect order of bigCards")
//                        }
//                    }
//                }
//            }
        }
        
        
        
        //Compare each card's position with the last card in the array
//        for i in 0...cardArray.endIndex {
//            let card = cardArray[i]
//            let previousCard = cardArray[i - 1]
//
//            var bigCards: [CardViewModel] = []
//
//            if card.size.width > CGSize.card.width && !bigCards.contains(card) {
//                bigCards.append(card)
//            }
//
//            if card.size.width == CGSize.card.width && bigCards.contains(card) {
//                bigCards.remove(at: i)
//            }
//
//            let cardIndex1 = card.cardModel!.index
//            let cardIndex2 = previousCard.cardModel!.index
//
//            if card != cardArray.first{
//                if bigCards.count == cardArray.count {
//                    if cardIndex1 < cardIndex2 {
//                        print("order is incorrect")
//                    } else {
//                        print("order is correct")
//                    }
//                }
//            }
//        }
//    }

}
