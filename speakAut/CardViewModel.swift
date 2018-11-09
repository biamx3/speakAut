//
//  CardViewModel.swift
//  speakAut
//
//  Created by Beatriz Melo Mousinho Magalhães on 31/08/18.
//  Copyright © 2018 Beatriz Melo Mousinho Magalhães. All rights reserved.
//

import UIKit
import SpriteKit

class CardViewModel: SKSpriteNode {

    private var card = SKSpriteNode()
    private var wordNode = SKLabelNode()
    private var imageNode = SKSpriteNode()
    private var cardIndex = Int()
    
    init(cardModel:Card) {
        let word = cardModel.word
        let image = cardModel.imageName
        super.init(texture: nil, color: .clear, size: CGSize.card)
        createCard()
        self.wordNode.text = word
        imageNode.texture = SKTexture(imageNamed: image)
        self.isUserInteractionEnabled = true
        self.zPosition = 7
        self.name = "card"
        self.addChild(card)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func imageSetUp() {
        self.imageNode = SKSpriteNode(color: .red, size: CGSize.cardImage)
        imageNode.zPosition = 5
        imageNode.position = CGPoint(x: 0, y: 20)
        imageNode.name = "image"
        card.addChild(imageNode)
    }
    
    func wordSetUp() {
        self.wordNode = SKLabelNode(text: "word")
        wordNode.fontColor = UIColor.greyishBrown
        wordNode.fontSize = 32
        wordNode.position = CGPoint(x: 0, y: -125)
        wordNode.zPosition = 5
        wordNode.name = "word"
        card.addChild(wordNode)
    }
    
    func cardSetUp() {
        self.card = SKSpriteNode(texture: SKTexture(imageNamed: "blankCard"))
        card.zPosition = 4
        card.name = "blankCard"
    }
    
    func createCard() {
        cardSetUp()
        imageSetUp()
        wordSetUp()
    }
    
    func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print("touchesBegan")
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self.parent ?? self)
        let previousPosition = touch.previousLocation(in: self.parent ?? self)
        
        for touch in touches {
            var translation:CGPoint = CGPoint(x: location.x - previousPosition.x , y: location.y - previousPosition.y )
            let newPosition = CGPoint(x: self.position.x + translation.x , y: self.position.y + translation.y)
            self.position = newPosition
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let brothers = self.parent?.allDescendants() else {return}
        let cards = brothers.filter {($0.name?.starts(with: "card") ?? false)}
        let gaps = brothers.filter {($0.name?.starts(with: "gap") ?? false)}
        var filledOutCards: [SKNode] = []
        
        if filledOutCards.count == cards.count - 1 {
            print("time to check")
        }
        
        for i in 0 ... cards.count - 1 {
            if (cards[i].near(gaps) != nil) {
                filledOutCards.append(cards[i] as! SKSpriteNode)
            }
            
            if cards[i].near(gaps) != nil && filledOutCards.count == cards.count {
                
            }
            
            if cards[i].near(gaps) != nil && filledOutCards.count == cards.count && filledOutCards.isInOrderedInX == true {
                print("Cards are in correct order")
            }
            
            if cards[i].near(gaps) != nil && filledOutCards.count == cards.count && filledOutCards.isInOrderedInX == false {
                print("Cards are in incorrect order")
            }
            
            /*else if cards[i].near(gaps) == nil || filledOutCards.count > 0 {
                let index = filledOutCards.lastIndex(of: cards[i] as! SKSpriteNode)
                filledOutCards.remove(at: index ?? 0)
                print("filledOutCards ", filledOutCards)
              //  filledOutCards.remove(at: filledOutCards[cards[i]])
            }*/
        }
        
//        for card in cards {
//            if (card.near(gaps) != nil) {
//                print("near")
//                filledOutCards.append(card as! SKSpriteNode)
//            }
//        }
        
//        for gap in gaps {
// 
//        }
//        print("gaps ", gaps.count, "brothers ", brothers.count)
        if let index = self.near(gaps) {
            let stickAnimation = SKAction.move(to: CGPoint(x: gaps[index].position.x, y:gaps[index].position.y ), duration: 0.2)
            stickAnimation.timingMode = .easeOut
            self.run(stickAnimation)
        }
    }
}

