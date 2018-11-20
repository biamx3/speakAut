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
}
