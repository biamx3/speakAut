//
//  MenuScene.swift
//  speakAut
//
//  Created by Beatriz Melo Mousinho Magalhães on 01/12/18.
//  Copyright © 2018 Beatriz Melo Mousinho Magalhães. All rights reserved.
//

import UIKit
import SpriteKit

class MenuScene: SKScene {
    
    weak var menuSceneDelegate: MenuSceneDelegate?
    
    override func didMove(to view: SKView) {
        self.scaleMode = .resizeFill
        self.isUserInteractionEnabled = true
        setUpChooseButton()
    }
    
    
    func setUpChooseButton(){
        let sceneSize = self.frame.size
        let chooseButtonTexture = SKTexture(imageNamed: "bigButton")
        
        let chooseButton = SKSpriteNode(texture: chooseButtonTexture, color: .clear, size: chooseButtonTexture.size())
        chooseButton.position = CGPoint(x: 0, y: -self.size.height*0.3)
        chooseButton.name = "choose"
        
        let chooseButtonLabel = SKLabelNode(text: "jogar")
        chooseButtonLabel.name = "chooseLabel"
        chooseButtonLabel.fontSize = 45
        chooseButtonLabel.fontName = "PeachyKeenJF"
        chooseButtonLabel.fontColor = .whiteish
        chooseButtonLabel.zPosition = 15
        chooseButtonLabel.position = CGPoint(x: 0, y: -10)
        chooseButton.addChild(chooseButtonLabel)
        self.addChild(chooseButton)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let position = touch.location(in: self)
        let touchedNode = atPoint(position)
        
        if touchedNode.name?.starts(with: "choose") ?? true {
            touchedNode.run(SKAction.animateButton, completion: {
                self.menuSceneDelegate?.goToSelectionScreen()
            })
        }
        
        if touchedNode.name == "chooseLabel" {
            touchedNode.parent?.run(SKAction.animateButton, completion: {
                self.menuSceneDelegate?.goToSelectionScreen()
            })
        }
    }
}

protocol MenuSceneDelegate: class {
    func goToSelectionScreen()
}
