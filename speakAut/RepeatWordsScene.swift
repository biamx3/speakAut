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
        addBackButton()
        
        let cardSetViewModel = CardSetViewModel(cardsOnly: cardSet)
        self.addChild(cardSetViewModel)
        
        //self.addChild(cardSetViewModel)
    }

    func addBackButton() {
        let sceneSize = UIScreen.main.bounds.size
        let backButtonTexture = SKTexture(imageNamed: "backButton")
        let touchArea = SKShapeNode(circleOfRadius: backButtonTexture.size().width*1.3)
        touchArea.strokeColor = .clear
        touchArea.name = "backButton"
        touchArea.position = CGPoint(x: -sceneSize.width/2.3 , y: sceneSize.height/2.4)
        let backButton = SKSpriteNode(texture: backButtonTexture, color: .clear, size: backButtonTexture.size())
        backButton.name = "backButton"
        touchArea.addChild(backButton)
        self.scene?.addChild(touchArea)
    }
}
