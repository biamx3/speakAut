//
//  TryAgainViewModel.swift
//  speakAut
//
//  Created by Beatriz Melo Mousinho Magalhães on 29/11/18.
//  Copyright © 2018 Beatriz Melo Mousinho Magalhães. All rights reserved.
//

import UIKit
import SpriteKit

class TryAgainViewModel: SKSpriteNode {

    var invisibleNode: SKSpriteNode!
    var cardType: CardType!
    
    init(cardViewModel: [CardViewModel], cardType: CardType){
        self.cardType = cardType
        super.init(texture: nil, color: .clear, size: UIScreen.main.bounds.size)
        SoundTrack.sharedInstance.playSound(withName: "wrong")
        self.isUserInteractionEnabled = false
        self.parent?.isUserInteractionEnabled = false
        setUpInvisibleNode()
        self.position = CGPoint(x: 0, y: 0)
        cardsAreWrong(cardNodes: cardViewModel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func errorMessage() -> SKLabelNode {
        let sceneSize = self.frame.size
        let errorMessage = SKLabelNode(text: "Tente novamente")
        errorMessage.name = "instructionsLabel"
        errorMessage.fontSize = 32
        errorMessage.fontName = "PeachyKeenJF"
        errorMessage.fontColor = UIColor.greyishBrown
        errorMessage.zPosition = 15
        errorMessage.name = "error message"
        if self.cardType == .GameScene {
            errorMessage.position = CGPoint(x: 0, y: sceneSize.height/6.7)
        } else {
            errorMessage.position = CGPoint(x: 0, y: sceneSize.height/2.7)
        }

        errorMessage.alpha = 0
        
        return errorMessage
    }
    
    //In case of GameScene
    func cardsAreWrong(cardNodes: [CardViewModel]){
        SoundTrack.sharedInstance.playSound(withName: "tente novamente")
        let errorLabel = errorMessage()
        self.addChild(errorLabel)
        
        //Turn off user interaction
        self.addChild(invisibleNode)
        self.isUserInteractionEnabled = false
        
        //Animate error label appearance
        let fadeIn = SKAction.fadeAlpha(to: 3.0, duration: 0.8)
        let wait = SKAction.wait(forDuration: 0.3)
        let fadeOut = SKAction.fadeOut(withDuration: 0.5)
        let animation = SKAction.sequence([fadeIn, wait,fadeOut])
        
        errorLabel.run(animation, completion: {
            errorLabel.removeFromParent()
            if self.cardType == .GameScene {
                 self.removeAllCardsFromGaps(cards: cardNodes)
            } else {
                self.repeatedCardsWrong(cardNodes: cardNodes)
            }
            self.parent?.isUserInteractionEnabled = true
            self.removeFromParent()
        })
    }
    
    func repeatedCardsWrong(cardNodes: [CardViewModel]){
        let scaleDown = SKAction.scale(to: 1.0, duration: 0.2)
        scaleDown.timingMode = .easeOut
        for card in cardNodes {
            card.run(scaleDown)
        }
    }
    
    func removeAllCardsFromGaps(cards: [CardViewModel]){
        //Animate cards moving out of gap
        let removeCardFromGap = SKAction.move(by: CGVector(dx: 0, dy: CGSize.card.height*1.1), duration: 0.2)
        let randomRotation = self.randomRotation()
        let removeCardFromGapGroup = SKAction.group([removeCardFromGap, randomRotation])
        removeCardFromGapGroup.timingMode = .easeOut
        
        SoundTrack.sharedInstance.playSound(withName: "cardSlide")
        
        for card in cards {
            card.run(removeCardFromGapGroup, completion: {
                //Turn on user interaction
                self.invisibleNode.removeFromParent()
                self.isUserInteractionEnabled = true
            })
        }
    }

    func randomRotation() -> SKAction {
        let randomAngle = Float.random(in: -0.3 ..< 0.3)
        let randomRotation = SKAction.rotate(byAngle: CGFloat(randomAngle), duration: 0.15)
        return randomRotation
    }
    
    func setUpInvisibleNode() {
        let sceneSize = self.frame.size
        invisibleNode = SKSpriteNode(color: .clear, size: sceneSize)
        invisibleNode.isUserInteractionEnabled = false
        invisibleNode.zPosition = 20
    }
}
