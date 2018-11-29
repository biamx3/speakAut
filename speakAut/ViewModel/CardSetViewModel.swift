//
//  CardSetViewModel.swift
//  speakAut
//
//  Created by Beatriz Melo Mousinho Magalhães on 06/11/18.
//  Copyright © 2018 Beatriz Melo Mousinho Magalhães. All rights reserved.
//



//TO DO CHANGE SIZE OF SCENE

import UIKit
import SpriteKit

class CardSetViewModel: SKSpriteNode {
    
    var cards: [CardViewModel] = [] //private
    var gaps: [GapViewModel] = []
    var cardType: CardType = .GameScene
    var cardPositions : [CGPoint] = []
    
    //RepeatWordsScene
    var bigCards: [CardViewModel] = []
    
    init(){
        super.init(texture: nil, color: .clear, size: UIScreen.main.bounds.size)
    }
    
    init(cardSet: [Card], type: CardType){
        super.init(texture: nil, color: .clear, size: UIScreen.main.bounds.size)
        self.name = "setOfCardsAndGaps"
        self.isUserInteractionEnabled = true
        self.cardType = type
        
        if self.cardType == .GameScene {
        addCards(from: cardSet)
        addGaps(from: cards)
        }
        
        if self.cardType == .RepeatWordsScene {
        addCardsToRepeatWordsScene(from: cardSet)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func shuffleCards2(){
        for i in 0...self.cards.count - 1 {
            if self.cards.count > 0 {
                let position = self.cards.randomElement()?.position
                let moveAction = SKAction.moveTo(x: position?.x ?? cards[i].position.x, duration: 0.2)
                if cards[i].position != position {
                    cards[i].run(moveAction)
                }
            }
        }
    }
    
    
    func shuffleCards(){
        if self.cards.count > 0 {
            //Compare each card's position with the last card in the array
            for i in 0...self.cards.count - 1{
                let card = self.cards[i]
                let index = i
                let lastItem = self.cards.last
                let lastIndex = self.cards.index(of: lastItem ?? card)
                let nextCard = self.cards[lastIndex ?? 0]
                
                //Animate cards moving out of gap
                let removeCardFromGap = SKAction.move(by: CGVector(dx: 0, dy: 180), duration: 0.2)
                let randomRotation = self.randomRotation()
                let removeCardFromGapGroup = SKAction.group([removeCardFromGap, randomRotation])
                removeCardFromGapGroup.timingMode = .easeOut
                
                //If two cards have the same position, remove the card with the lowest zPosition from the gap
                if index != lastIndex && card.position == nextCard.position   {
                    if card.zPosition < nextCard.zPosition {
                        card.run(removeCardFromGapGroup)
                    } else {
                        nextCard.run(removeCardFromGapGroup)
                    }
                }
            }
        }
    }
    
    func addCards(from cardSet: [Card]) {
        let sceneSize = self.parent?.frame.size
        
        let cardMargin:CGFloat = 60 // Margem entre cartas
        let cardQnt = CGFloat(cardSet.count) // Quantidade de cartas
        let cardConstantSpacing = CGSize.card.width + cardMargin // Distância entre os centros das cartas
        
        let totalSpace = (CGSize.card.width * cardQnt) + (cardMargin * (cardQnt - 1))
        let firstXposition = -((totalSpace / 2) - (CGSize.card.width / 2))
        
        
        for i in 0..<cardSet.count {
            let cardView = CardViewModel(cardModel: cardSet[i], type: .GameScene)
            
            let cardXPosition = firstXposition + (cardConstantSpacing * i.cgFloat)
            cardView.position = CGPoint(x: cardXPosition, y: (sceneSize?.height ?? 0.0) + 180)
            randomRotation(node: cardView)
            
            self.addChild(cardView)
            cards.append(cardView)
        }
        
            shuffleCards()
        
        for i in 0..<cardSet.count {
            print("card position", self.cards[i].position)
        }
        
    }
    
    func addCardsToRepeatWordsScene(from cardSet: [Card]) {
        let sceneSize = self.parent?.frame.size
        
        let cardMargin:CGFloat = 60 // Margem entre cartas
        let cardQnt = CGFloat(cardSet.count) // Quantidade de cartas
        let cardConstantSpacing = CGSize.card.width + cardMargin // Distância entre os centros das cartas
        
        let totalSpace = (CGSize.card.width * cardQnt) + (cardMargin * (cardQnt - 1))
        let firstXposition = -((totalSpace / 2) - (CGSize.card.width / 2))
        
        for i in 0..<cardSet.count {
            let cardView = CardViewModel(cardModel: cardSet[i], type: .GameScene)
            
            let cardXPosition = firstXposition + (cardConstantSpacing * i.cgFloat)
            cardView.position = CGPoint(x: cardXPosition, y: (sceneSize?.height ?? 0.0))
            self.addChild(cardView)
            cards.append(cardView)
            
        }
    }
    
    func randomRotation(node: SKSpriteNode){
        let randomAngle = Float.random(in: -0.5 ..< 0.3)
        node.run(SKAction.rotate(byAngle: CGFloat(randomAngle), duration: 0))
    }
    
    func addGaps(from cards: [CardViewModel]) {
        let sceneSize = self.parent?.frame.size
        
        for card in cards {
            let gap = GapViewModel()
            gap.position = CGPoint(x: card.position.x, y:  (sceneSize?.height ?? 0.0) - 180)
            self.addChild(gap)
            self.gaps.append(gap)
        }
    }
    
    func randomRotation() -> SKAction {
        let randomAngle = Float.random(in: -0.5 ..< 0.5)
        let randomRotation = SKAction.rotate(byAngle: CGFloat(randomAngle), duration: 0.15)
        return randomRotation
    }
    
    func removeGaps(){
        for gap in self.gaps {
            gap.removeFromParent()
        }
    }
    
    //–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            if self.cardType == .GameScene {
                self.parent?.touchesEnded(touches, with: event)
            } else if self.cardType == .RepeatWordsScene {
                self.parent?.touchesEnded(touches, with: event)
                
                
                
//                if self.bigCards.count == self.cards.count {
//                    if self.bigCards == self.cards {
//
//                    } else {
//                        for card in self.cards {
//                            card.repeatedCardsWrong()
//                            self.bigCards = []
//                        }
//                    }
//                }
        }
    }
}
