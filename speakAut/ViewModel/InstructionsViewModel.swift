//
//  RepeatWordsSceneInstructions.swift
//  speakAut
//
//  Created by Beatriz Melo Mousinho Magalhães on 22/11/18.
//  Copyright © 2018 Beatriz Melo Mousinho Magalhães. All rights reserved.
//

import UIKit
import SpriteKit

class InstructionsViewModel: SKSpriteNode {
    
    private var wait: SKAction!
    
    init(cardType: CardType){
        super.init(texture: SKTexture(imageNamed: "backgroundImage"), color: .clear, size: UIScreen.main.bounds.size)
        self.isUserInteractionEnabled = false
        self.position = CGPoint(x: 0, y: 0)
        setUpInstructionsLabel(cardType: cardType)
        animate()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpInstructionsLabel(cardType: CardType) {
        
        let sceneSize = self.frame.size
        let instructionsLabel = SKLabelNode(fontNamed: "PeachyKeenJF")
        instructionsLabel.name = "instructionsLabel"
        instructionsLabel.preferredMaxLayoutWidth = sceneSize.width*0.8
        instructionsLabel.fontSize = 32
        instructionsLabel.fontColor = UIColor.greyishBrown
        instructionsLabel.zPosition = 5
        instructionsLabel.position = CGPoint(x: 0, y: 0)
        
        if cardType == .GameScene {
            SoundTrack.sharedInstance.playInstructions(withName: "coloqueAsCartas")
            instructionsLabel.text = "Coloque as cartas na ordem certa!"
            self.wait = SKAction.wait(forDuration: 3.0)
        }
        
        if cardType == .RepeatWordsScene {
            SoundTrack.sharedInstance.playInstructions(withName: "repita")
            instructionsLabel.text = "Toque nas cartas e repita as palavras na ordem certa!"
            self.wait = SKAction.wait(forDuration: 5.5)
        }
        
        self.addChild(instructionsLabel)
    }
    
    func animate(){
        //TO DO: Play Sound
        let moveOut = SKAction.move(to: CGPoint(x: 0, y: self.size.height*2), duration: 0.6)
        self.run(self.wait, completion: {
            SoundTrack.sharedInstance.playSound(withName: "screenSlide")
            self.run(moveOut, completion: {
                self.removeFromParent()
            })
        })
    }
}


