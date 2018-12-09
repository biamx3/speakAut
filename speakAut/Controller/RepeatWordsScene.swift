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
     private var invisibleNode: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        self.scaleMode = .resizeFill
        self.isUserInteractionEnabled = true
        addCards()
        addInstructions()
        setUpInvisibleNode()
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
    
    func setUpInvisibleNode() {
        let sceneSize = self.frame.size
        invisibleNode = SKSpriteNode(color: .clear, size: sceneSize)
        invisibleNode.isUserInteractionEnabled = false
        invisibleNode.zPosition = -1
        self.addChild(invisibleNode)
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
    
    func goToSuccessAnimationScreen(){
        self.repeatViewControllerDelegate?.goToSuccessAnimationScreen()
    }
    
    override func willMove(from view: SKView) {
        self.removeFromParent()
        for child in self.children {
            child.removeFromParent()
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let cardViews = self.identifyCardsInScreen()
        if self.cardSetViewModel.bigCards.count == cardViews!.count {
            if self.cardSetViewModel.bigCards == cardViews {
                self.invisibleNode.zPosition = 20
                self.run(SKAction.wait(forDuration: 1.0), completion: {
                    DispatchQueue.main.async {
                        let celebrationViewModel = CelebrationViewModel(cardViewModel: cardViews!, cardType: .RepeatWordsScene)
                        self.addChild(celebrationViewModel)
                    }
                })
                
            } else {
                self.run(SKAction.wait(forDuration: 1.0), completion: {
                    DispatchQueue.main.async {
                        let tryAgainViewModel = TryAgainViewModel(cardViewModel: cardViews!, cardType: .RepeatWordsScene)
                        self.addChild(tryAgainViewModel)
                        self.cardSetViewModel.bigCards = []
                    }
                })
                
            }
        }
    }
}



protocol RepeatViewControllerDelegate: class {
    func goToSuccessAnimationScreen()
}

