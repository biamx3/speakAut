//
//  UICharSelection.swift
//  speakAut
//
//  Created by Beatriz Melo Mousinho Magalhães on 14/11/18.
//  Copyright © 2018 Beatriz Melo Mousinho Magalhães. All rights reserved.
//

import UIKit
import SpriteKit
import SceneKit

class UICharSelection: SKScene {
    
    private var charNextButton: SKSpriteNode!
    private var charBackButton: SKSpriteNode!
    private var backButton: SKSpriteNode!
    private var instructionsLabel: SKLabelNode!
    private var chooseButton: SKSpriteNode!
    private var chooseButtonLabel: SKLabelNode!
    
    
    override init(size: CGSize) {
        super.init(size: size)
        self.backgroundColor = .clear
        setUpCarousselButtons()
        setUpInstructionsLabel()
        setUpChooseButton()
    }
    
    
    func setUpInstructionsLabel() {
        let sceneSize = self.frame.size
        
        self.instructionsLabel = SKLabelNode(text: "Escolha um personagem!")
        self.instructionsLabel.name = "instructionsLabel"
        self.instructionsLabel.fontSize = 32
        self.instructionsLabel.fontColor = UIColor.greyishBrown
        self.instructionsLabel.zPosition = 15
        self.instructionsLabel.position = CGPoint(x: sceneSize.width/2, y: sceneSize.height - 100)
        
        self.addChild(instructionsLabel)
    }
    
    func setUpCarousselButtons() {
        let sceneSize = self.frame.size
        let charBackButtonTexture = SKTexture(imageNamed: "characterBackButton")
        let charNextButtonTexture = SKTexture(imageNamed: "characterNextButton")
        
        self.charBackButton = SKSpriteNode(texture: charBackButtonTexture, color: .clear, size: charBackButtonTexture.size())
        self.charNextButton = SKSpriteNode(texture: charNextButtonTexture, color: .clear, size: charNextButtonTexture.size())
        
        self.charBackButton.name = "charBack"
        self.charNextButton.name = "charNext"
        
        self.charBackButton.zPosition = 15
        self.charNextButton.zPosition = 15
        
        
        self.charBackButton.position = CGPoint(x: sceneSize.width/2 - 390, y: sceneSize.height/2 - charBackButtonTexture.size().height/2)
        self.charNextButton.position = CGPoint(x: sceneSize.width/2 + 390, y: sceneSize.height/2 - charBackButtonTexture.size().height/2)
        
        self.addChild(charBackButton)
        self.addChild(charNextButton)
    }
    
    func setUpChooseButton(){
        let sceneSize = self.frame.size
        let chooseButtonTexture = SKTexture(imageNamed: "bigButton")
        
        self.chooseButton = SKSpriteNode(texture: chooseButtonTexture, color: .clear, size: chooseButtonTexture.size())
        self.chooseButton.position = CGPoint(x: sceneSize.width/2, y: chooseButtonTexture.size().height*0.6)
        self.chooseButton.name = "charChoose"

        
        self.chooseButtonLabel = SKLabelNode(text: "escolher")
        self.chooseButtonLabel.name = "chooseLabel"
        self.chooseButtonLabel.fontSize = 50
        self.chooseButtonLabel.fontColor = .white
        self.chooseButtonLabel.zPosition = 15
        self.chooseButtonLabel.position = CGPoint(x: 0, y: -10)
        self.chooseButton.addChild(chooseButtonLabel)
        self.addChild(chooseButton)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let position = touch.location(in: self)
        let touchedNode = atPoint(position)

        if touchedNode.name?.starts(with: "char") ?? true {
            touchedNode.run(SKAction.animateButton)
        }
        
        if touchedNode.name == "chooseLabel" {
            touchedNode.parent?.run(SKAction.animateButton)
        }
    }
    
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let position = touch.location(in: self)
        let touchedNode = atPoint(position)
        
        switch touchedNode.name {
        case "charNext":
            print("next character")
            
        case "charBack":
            print("last character")
            let carousselCharSelection = CarousselCharSelection()
            carousselCharSelection.turnRed()
            
        case "charChoose":
            print("chose character")

            
            
        default:
            break
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

