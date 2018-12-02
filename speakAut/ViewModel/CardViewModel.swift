//
//  CardViewModel.swift
//  speakAut
//
//  Created by Beatriz Melo Mousinho Magalhães on 31/08/18.
//  Copyright © 2018 Beatriz Melo Mousinho Magalhães. All rights reserved.
//


//TO DO: VERIFY IF GAP IS OCCUPIED

import UIKit
import SpriteKit

class CardViewModel: SKSpriteNode {

    private var card = SKSpriteNode()
    private var wordNode = SKLabelNode()
    private var imageNode = SKSpriteNode()
    private var cardType: CardType!
    var cardModel: Card!

    init(cardModel:Card, type: CardType) {
        // minimum init
        super.init(texture: nil, color: .clear, size: CGSize.card)
        self.zPosition = 2
        self.isUserInteractionEnabled = true
        self.name = "card" + cardModel.word
        
        self.cardModel = cardModel
        //Is this card being used in the GameScene or RepeatWordsScene?
        self.cardType = type
        
        // add card elements
        cardSetUp()
        imageNode.texture = SKTexture(imageNamed: self.cardModel.imageName)
        self.wordNode.text = self.cardModel.word
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func randomRotation(){
        let randomAngle = Float.random(in: -0.5 ..< 0.3)
        self.run(SKAction.rotate(byAngle: CGFloat(randomAngle), duration: 0))
    }
    
    func cardSetUp() {
        self.card = SKSpriteNode(texture: SKTexture(imageNamed: "blankCard"))
        card.zPosition = 1
        card.name = "blankCard"
        
        imageSetUp()
        wordSetUp()
        self.addChild(card)
    }
    
    func imageSetUp() {
        self.imageNode = SKSpriteNode(color: .red, size: CGSize.cardImage)
        imageNode.position = CGPoint(x: 0, y: 20)
        imageNode.zPosition = 1
        imageNode.name = "image"
        
        card.addChild(imageNode)
    }
    
    func wordSetUp() {
        self.wordNode = SKLabelNode(text: "word")
        wordNode.fontColor = UIColor.greyishBrown
        wordNode.fontName = "SF-Pro-Text-Regular"
        wordNode.fontSize = 32
        wordNode.position = CGPoint(x: 0, y: -125)
        wordNode.zPosition = 1
        wordNode.name = "word"
        
        card.addChild(wordNode)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let brothers = self.parent?.allDescendants() else {return}
        let cards = brothers.filter {($0.name?.starts(with: "card") ?? false)}
        
        let parent = self.parent as! CardSetViewModel
        
        if parent.cardType == .GameScene {
            //---------- The card you touch is highest in the hierarchy ------//
            //Get all cards in scene excluding the one that is being touched
            let filteredCards = cards.filter { $0 != self }
            let cardBros = filteredCards as! [CardViewModel]
            
            //Animate up
            SoundTrack.sharedInstance.playSound(withName: "cardInFocus")
            let scaleUp = SKAction.scale(to: 1.15, duration: 0.2)
            let rotateToCorrect = SKAction.rotate(toAngle: 0.0, duration: 0.2)
            let scaleUpGroup = SKAction.group([scaleUp, rotateToCorrect])
            scaleUpGroup.timingMode = .easeOut
            self.run(scaleUpGroup)
            
            //Move card that is being touched higher in the hierarchy
            for index in cardBros {
                self.zPosition = 3
                self.card.zPosition = 2
                index.zPosition = self.zPosition - 1
                index.card.zPosition = self.card.zPosition - 1
            }
        }
            
        else if parent.cardType == .RepeatWordsScene {
            if self.size == CGSize.card {
                SoundTrack.sharedInstance.playSound(withName: "cardInFocus")
                let scaleUp = SKAction.scale(to: 1.15, duration: 0.2)
                scaleUp.timingMode = .easeOut
                self.run(scaleUp)
            } else {
                let scaleToNormal = SKAction.scale(to: 1.0, duration: 0.2)
                scaleToNormal.timingMode = .easeOut
                self.run(scaleToNormal)
            }
        }
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let parent = self.parent as! CardSetViewModel
        if parent.cardType == .GameScene {
            guard let touch = touches.first else { return }
            let location = touch.location(in: self.parent ?? self)
            let previousPosition = touch.previousLocation(in: self.parent ?? self)
            
            for _ in touches {
                let translation:CGPoint = CGPoint(x: location.x - previousPosition.x , y: location.y - previousPosition.y )
                let newPosition = CGPoint(x: self.position.x + translation.x , y: self.position.y + translation.y)
                self.position = newPosition
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let parent = self.parent as! CardSetViewModel
        //Filter all nodes in scene to identify gaps and cards
        guard let brothers = self.parent?.allDescendants() else {return}
        let gaps = brothers.filter {($0.name?.starts(with: "gap") ?? false)}
        
        if  parent.cardType == .GameScene {
            //Animate back to correct scale
            let scaleDown = SKAction.scale(to: 1.0, duration: 0.2)
            scaleDown.timingMode = .easeOut
            self.run(scaleDown)
            
            //Have cards stick to gaps
            if let index = self.near(gaps) {
                SoundTrack.sharedInstance.playSound(withName: "cardFitsInGap")
                let stickAnimation = SKAction.move(to: CGPoint(x: gaps[index].position.x, y:gaps[index].position.y ), duration: 0.2)
                stickAnimation.timingMode = .easeOut
                self.run(stickAnimation)
            }
            
            self.parent?.touchesEnded(touches, with: event)
        }
        
        //If card is being used in RepeatWordsScene
        if parent.cardType == .RepeatWordsScene {
            //If the card is big, append to parent's bigCardsArray
            if self.size.width > CGSize.card.width {
                if !parent.bigCards.contains(self) {
                    parent.bigCards.append(self)
                    self.parent?.touchesEnded(touches, with: event)
                }
            } else {
                if parent.bigCards.contains(self) {
                    let index = parent.bigCards.index(of: self)
                    parent.bigCards.remove(at: index ?? 0)
                    self.parent?.touchesEnded(touches, with: event)
                }
            }
        }
    }
}

