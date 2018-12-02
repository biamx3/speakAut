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

     weak var repeatViewControllerDelegate: RepeatViewControllerDelegate?
     var cardSetViewModel: CardSetViewModel!
     var bigCards: [CardViewModel]!
    
    override func didMove(to view: SKView) {
        self.scaleMode = .resizeFill
        self.isUserInteractionEnabled = true
        addCards()
        addInstructions()
    }
    
    func addCards(){
        let cardArray = DAO.sharedInstance.chosenSentence.cardArray
        self.cardSetViewModel = CardSetViewModel(cardSet: cardArray, type: .RepeatWordsScene)
        cardSetViewModel.position = CGPoint(x: 0, y: 0)
        cardSetViewModel.zPosition = 3
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
    
    func addInstructions(){
        let instructionsViewModel = InstructionsViewModel(cardType: .RepeatWordsScene)
        instructionsViewModel.zPosition = 15
        self.addChild(instructionsViewModel)
    }

    func addBackButton() {
        let sceneSize = UIScreen.main.bounds.size
        let backButtonTexture = SKTexture(imageNamed: "backButton")
        let touchArea = SKShapeNode(circleOfRadius: backButtonTexture.size().width*1.3)
        touchArea.strokeColor = .clear
        touchArea.name = "backButton"
        touchArea.position = CGPoint(x: -sceneSize.width/5 , y: sceneSize.height/2.4)
        let backButton = SKSpriteNode(texture: backButtonTexture, color: .clear, size: backButtonTexture.size())
        backButton.name = "backButton"
        touchArea.addChild(backButton)
        touchArea.zPosition = 4
        self.addChild(touchArea)
    }
    
    func identifyCardsInScreen() -> [CardViewModel]! {
        let brothers = self.allDescendants()
        let cardsInScreen = brothers.filter {($0.name?.starts(with: "card") ?? false)}
        let cardViews = cardsInScreen as! [CardViewModel]
        return cardViews
    }
    
    func identifyGapsInScreen() -> [SKNode]! {
        let brothers = self.allDescendants()
        let gapsInScreen = brothers.filter {($0.name?.starts(with: "gap") ?? false)}
        let gapViews = gapsInScreen as! [GapViewModel]
        return gapViews
    }
    
    func goToSuccessAnimationScreen(){
        self.repeatViewControllerDelegate?.goToSuccessAnimationScreen()
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.cardSetViewModel.bigCards.count == self.cardSetViewModel.cards.count {
            if self.cardSetViewModel.bigCards == self.cardSetViewModel.cards {
                let celebrationViewModel = CelebrationViewModel(cardViewModel: self.cardSetViewModel.cards, cardType: .RepeatWordsScene)
                self.addChild(celebrationViewModel)
                
            } else {
                for _ in self.cardSetViewModel.cards {
                    let tryAgainViewModel = TryAgainViewModel(cardViewModel: self.cardSetViewModel.cards, cardType: .RepeatWordsScene)
                    self.addChild(tryAgainViewModel)
                    self.cardSetViewModel.bigCards = []
                }
            }
        }
    }
}

protocol RepeatViewControllerDelegate: class {
    func goToSuccessAnimationScreen()
}

