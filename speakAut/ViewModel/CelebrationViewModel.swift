//
//  CelebrationViewModel.swift
//  speakAut
//
//  Created by Beatriz Melo Mousinho Magalhães on 29/11/18.
//  Copyright © 2018 Beatriz Melo Mousinho Magalhães. All rights reserved.
//

import UIKit
import SpriteKit

class CelebrationViewModel: SKSpriteNode {
    
    var invisibleNode: SKSpriteNode!
    var cardType: CardType!
    
    init(cardViewModel: [CardViewModel], cardType: CardType){
        self.cardType = cardType
        super.init(texture: nil, color: .clear, size: UIScreen.main.bounds.size)
        self.isUserInteractionEnabled = false
        setUpInvisibleNode()
        self.position = CGPoint(x: 0, y: 0)
        cardsAreRight(cardNodes: cardViewModel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpInvisibleNode() {
        let sceneSize = self.frame.size
        invisibleNode = SKSpriteNode(color: .clear, size: sceneSize)
        invisibleNode.isUserInteractionEnabled = false
        invisibleNode.zPosition = 20
    }
    
    func cardsAreRight(cardNodes: [CardViewModel]) {
        //Turn off user interaction
        self.addChild(invisibleNode)
        self.isUserInteractionEnabled = false
        let successLabel = successMessage()
        self.animateCards(cards: cardNodes)
        self.addParticles()
        
        successLabel.run(self.labelAnimation(), completion: {
            if self.cardType == .GameScene {
                let parent = self.parent as! GameScene
                parent.gameSceneDelegate?.goToRepeatWordsScene()
            }
                
            else if self.cardType == .RepeatWordsScene {
                let parent = self.parent as! RepeatWordsScene!
                parent!.goToSuccessAnimationScreen()
            }
        })
    }
    
    func addParticles(){
        let particleTypes:[(name:String, positionY:CGFloat)] = [(name:"particle", positionY:UIScreen.main.bounds.size.height/2), (name:"buttonParticle", positionY:0)]
        let choosedParticle = particleTypes.randomElement()!
        
        let wait = SKAction.wait(forDuration: 6.0)
        
        for i in 1...3 {
            if let emitter = SKEmitterNode(fileNamed: choosedParticle.name) {
                emitter.particleTexture = SKTexture(imageNamed: "particle\(i)")
                emitter.position = CGPoint(x: 0, y: choosedParticle.positionY)
                emitter.name = "particleEmitter"
                self.addChild(emitter)
            }
        }
        guard let brothers = self.parent?.allDescendants() else {return}
        let particleEmitters = brothers.filter {($0.name?.starts(with: "particleEmitter") ?? false)}
        let particleArray = particleEmitters as! [SKEmitterNode]
        
        self.run(wait, completion: {
            for particle in particleArray {
                particle.removeFromParent()
            }
        })
    }
    
    func successMessage() -> SKLabelNode {
        let sceneSize = self.frame.size
        let successMessageLabel = SKLabelNode(text: "Você acertou!")
        successMessageLabel.name = "instructionsLabel"
        successMessageLabel.fontSize = 32
        successMessageLabel.fontColor = UIColor.pumpkinOrange
        successMessageLabel.zPosition = 15
        successMessageLabel.fontName = "PeachyKeenJF"
        
        if self.cardType == .GameScene {
            successMessageLabel.position = CGPoint(x: 0, y: sceneSize.height/2.7)
        } else {
            successMessageLabel.position = CGPoint(x: 0, y: sceneSize.height/2.7)
        }
        self.addChild(successMessageLabel)
        return successMessageLabel
    }
    
    func animateCards(cards: [CardViewModel]){
        //Animate cards scaling
        let scaleUp1 = SKAction.scale(to: 1.2, duration: 0.1)
        scaleUp1.timingMode = .easeOut
        let scaleDown1 = SKAction.scale(to: 0.9, duration: 0.1)
        scaleDown1.timingMode = .easeOut
        let scaleUp2 = SKAction.scale(to: 1.4, duration: 0.2)
        scaleUp2.timingMode = .easeOut
        
        let scaleSequence = SKAction.sequence([scaleUp1, scaleDown1])
        
        let animation: SKAction!
        
        if self.cardType == .GameScene {
            let move = SKAction.move(by: CGVector(dx: 0, dy: CGSize.card.height*0.5), duration: 0.2)
            animation = SKAction.group([scaleSequence, move, scaleUp2])
        } else {
            animation = SKAction.group([scaleSequence, scaleUp2])
        }
        
        animation.timingMode = .easeInEaseOut
        
        //Animate cards twisting
        for card in cards {
            let cardIndex = CGFloat(cards.index(of: card) ?? 1)
            let increasingAngle = 0.1*cardIndex
            let rotation = SKAction.rotate(byAngle: CGFloat(-increasingAngle), duration: 0.2)
            rotation.timingMode = .easeOut
            let animationGroup = SKAction.group([animation, rotation])
            
            if card == cards[0] {
                let rotation = SKAction.rotate(byAngle: 0.1, duration: 0.2)
                rotation.timingMode = .easeOut
                card.run(animationGroup)
            } else {
                card.run(animationGroup)
            }
        }
    }
    
    func labelAnimation()->SKAction {
        //Animate error label appearance
        let scaleUp = SKAction.scale(to: 2.0, duration: 0.10)
        let moveDown = SKAction.moveBy(x: 0, y: -15, duration: 0.1)
        moveDown.timingMode = .easeOut
        let wait = SKAction.wait(forDuration: 3.0)
        let scaleAndMove = SKAction.group([scaleUp, moveDown])
        let popAnimation = SKAction.sequence([scaleAndMove, wait])
        
        return popAnimation
    }
}
