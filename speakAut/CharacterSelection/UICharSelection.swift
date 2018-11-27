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
    
    weak var uiCharSelectionDelegate: UICharSelectionDelegate?
    
    override init(size: CGSize) {
        super.init(size: size)
        self.backgroundColor = .clear
        self.zPosition = 10
        setUpCarousselButtons()
        setUpInstructionsLabel()
        setUpChooseButton()
    }
    
    func setUpInstructionsLabel() {
        let sceneSize = self.frame.size
        let instructionsLabel = SKLabelNode(text: "Escolha um personagem!")
        instructionsLabel.name = "instructionsLabel"
        instructionsLabel.fontName = "PeachyKeenJF"
        instructionsLabel.fontSize = 32
        instructionsLabel.fontColor = UIColor.greyishBrown
        instructionsLabel.zPosition = 15
        instructionsLabel.position = CGPoint(x: sceneSize.width/2, y: sceneSize.height - 100)
        
//        for family in UIFont.familyNames.sorted() {
//            let names = UIFont.fontNames(forFamilyName: family)
//            print("Family: \(family) Font names: \(names)")
//        }
        
        self.addChild(instructionsLabel)
    }
    

    
    func setUpCarousselButtons() {
        let sceneSize = self.frame.size
        let charBackButtonTexture = SKTexture(imageNamed: "characterBackButton")
        let charNextButtonTexture = SKTexture(imageNamed: "characterForwardButton")
        
        let charBackButton = SKSpriteNode(texture: charBackButtonTexture, color: .clear, size: charBackButtonTexture.size())
        let charNextButton = SKSpriteNode(texture: charNextButtonTexture, color: .clear, size: charNextButtonTexture.size())
        
        charBackButton.name = "charBack"
        charNextButton.name = "charNext"
        
        charBackButton.zPosition = 15
        charNextButton.zPosition = 15
        
        
        charBackButton.position = CGPoint(x: sceneSize.width/2 - 390, y: sceneSize.height/2 - charBackButtonTexture.size().height/2)
        charNextButton.position = CGPoint(x: sceneSize.width/2 + 390, y: sceneSize.height/2 - charBackButtonTexture.size().height/2)
        
        self.addChild(charBackButton)
        self.addChild(charNextButton)
    }
    
    func setUpChooseButton(){
        let sceneSize = self.frame.size
        let chooseButtonTexture = SKTexture(imageNamed: "bigButton")
        
        let chooseButton = SKSpriteNode(texture: chooseButtonTexture, color: .clear, size: chooseButtonTexture.size())
        chooseButton.position = CGPoint(x: sceneSize.width/2, y: chooseButtonTexture.size().height*0.6)
        chooseButton.name = "chooseLabel"

        let chooseButtonLabel = SKLabelNode(text: "escolher")
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
            //Next character
            self.uiCharSelectionDelegate?.nextCharacter()
            
        case "charBack":
            //Last character
            self.uiCharSelectionDelegate?.previousCharacter()
            
        case "charChoose":
            //Chose character
            self.uiCharSelectionDelegate?.selectCharacter()
            
        case "chooseLabel":
            //Chose character
            self.uiCharSelectionDelegate?.selectCharacter()
            
        default:
            break
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

protocol UICharSelectionDelegate: class {
    func previousCharacter()
    func nextCharacter()
    func selectCharacter()
    func goToMenuScreen()
}
