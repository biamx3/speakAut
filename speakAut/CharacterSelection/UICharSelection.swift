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
    private var invisibleNode: SKSpriteNode!
    
    override init(size: CGSize) {
        super.init(size: size)
        self.backgroundColor = .clear
        self.zPosition = 10
        setUpCarousselButtons()
        setUpInstructionsLabel()
        setUpChooseButton()
        setUpInvisibleNode()
        addBackButton()
        self.run((SKAction.wait(forDuration: 2.5)), completion: {
         self.uiCharSelectionDelegate?.playFirstSound()
            })
    }
    
    func setUpInstructionsLabel() {
        let sceneSize = self.frame.size
        let instructionsLabel = SKLabelNode(text: "Escolha o seu personagem!")
        instructionsLabel.name = "instructionsLabel"
        instructionsLabel.fontName = "PeachyKeenJF"
        instructionsLabel.fontSize = 32
        instructionsLabel.fontColor = UIColor.greyishBrown
        instructionsLabel.zPosition = 15
        instructionsLabel.position = CGPoint(x: sceneSize.width/2, y: sceneSize.height - 100)
        
        self.addChild(instructionsLabel)
    }
    
    func setUpInvisibleNode() {
        let sceneSize = self.frame.size
        invisibleNode = SKSpriteNode(color: .clear, size: sceneSize)
        invisibleNode.isUserInteractionEnabled = false
        invisibleNode.zPosition = -1
        self.addChild(invisibleNode)
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
        chooseButton.position = CGPoint(x: sceneSize.width/2, y: chooseButtonTexture.size().height*0.9)
        chooseButton.name = "chooseLabel"

        let chooseButtonLabel = SKLabelNode(text: "escolher")
        chooseButtonLabel.name = "chooseLabel"
        chooseButtonLabel.fontSize = 45
        chooseButtonLabel.fontName = "PeachyKeenJF"
        chooseButtonLabel.fontColor = .whiteish
        chooseButtonLabel.zPosition = 5
        chooseButtonLabel.position = CGPoint(x: 0, y: -10)
        chooseButton.addChild(chooseButtonLabel)
        
        let touchArea = SKShapeNode(rectOf: chooseButtonTexture.size())
        touchArea.fillColor = .clear
        touchArea.strokeColor = .clear
        touchArea.name = "touch"
        touchArea.position = CGPoint(x: 0, y: 0)
        chooseButton.addChild(touchArea)
        touchArea.zPosition = 10
        
        self.addChild(chooseButton)
    }
    
    
    func addBackButton() {
        let sceneSize = self.frame.size
        let backButtonTexture = SKTexture(imageNamed: "backButton")
        let touchArea = SKShapeNode(circleOfRadius: backButtonTexture.size().width*1.3)
        touchArea.strokeColor = .clear
        touchArea.name = "backButton"
        touchArea.position = CGPoint(x: sceneSize.width/9.4, y: sceneSize.height*0.89)
        let backButton = SKSpriteNode(texture: backButtonTexture, color: .clear, size: backButtonTexture.size())
        backButton.name = "backButton"
        backButton.zPosition = 12
        print("button position:", backButton.position)
        touchArea.addChild(backButton)
        self.addChild(touchArea)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let position = touch.location(in: self)
        let touchedNode = atPoint(position)
        
        if touchedNode.name?.starts(with: "char") ?? false {
            touchedNode.run(SKAction.animateButton)
            SoundTrack.sharedInstance.playSound(withName: "buttonMain")
        }
        if touchedNode.name?.starts(with: "backButton") ?? false {
            touchedNode.run(SKAction.animateButton, completion: {
                DispatchQueue.main.async {
                   self.uiCharSelectionDelegate?.goToMenuScreen()
                }
            })
            
        }
        
        if touchedNode.name == "touch" {
            self.invisibleNode.zPosition = 20
            SoundTrack.sharedInstance.playSound(withName: "buttonMain")
            SoundTrack.sharedInstance.playSound(withName: "correct")
            touchedNode.parent?.run(SKAction.animateButton)
            self.run(SKAction.wait(forDuration: 0.2), completion: {
                DispatchQueue.main.async {
                    self.uiCharSelectionDelegate?.selectCharacter()
                }
            })

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
            
        case "touch":
            //Chose character
            print("touchedCharacter")
            
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
    func playFirstSound()
}
