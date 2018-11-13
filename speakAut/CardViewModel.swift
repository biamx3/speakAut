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
    private var cardModel: Card!

    init(cardModel:Card) {
        self.cardModel = cardModel
        let word = cardModel.word
        let image = cardModel.imageName
        super.init(texture: nil, color: .blue, size: CGSize.card)
        createCard()
        self.zPosition = 2
        self.wordNode.text = word
        imageNode.texture = SKTexture(imageNamed: image)
        self.isUserInteractionEnabled = true
        self.name = "cardModel"
        self.addChild(card)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        wordNode.fontSize = 32
        wordNode.position = CGPoint(x: 0, y: -125)
        wordNode.zPosition = 1
        wordNode.name = "word"
        card.addChild(wordNode)
    }
    
    func cardSetUp() {
        self.card = SKSpriteNode(texture: SKTexture(imageNamed: "blankCard"))
        card.zPosition = 1
        card.name = "blankCard"
    }
    
    func createCard() {
        cardSetUp()
        imageSetUp()
        wordSetUp()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let brothers = self.parent?.allDescendants() else {return}
        let cards = brothers.filter {($0.name?.starts(with: "card") ?? false)}
        
        //Get all cards in scene excluding the one that is being touched
        let filteredCards = cards.filter { $0 != self }
        let cardBros = filteredCards as! [CardViewModel]

        //Move card that is being touched higher in the hierarchy
        for index in cardBros {
            self.zPosition = 3
            self.card.zPosition = 2
            index.zPosition = self.zPosition - 1
            index.card.zPosition = self.card.zPosition - 1
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self.parent ?? self)
        let previousPosition = touch.previousLocation(in: self.parent ?? self)
        
        for _ in touches {
            let translation:CGPoint = CGPoint(x: location.x - previousPosition.x , y: location.y - previousPosition.y )
            let newPosition = CGPoint(x: self.position.x + translation.x , y: self.position.y + translation.y)
            self.position = newPosition
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let brothers = self.parent?.allDescendants() else {return}
        let cards = brothers.filter {($0.name?.starts(with: "card") ?? false)}
        let gaps = brothers.filter {($0.name?.starts(with: "gap") ?? false)}
        let cardArray = cards as! [CardViewModel]
        
        
        //Check if cards are in the correct order when all gaps are filled
        if cards.near(gaps) {
            if cardArray.isOrderedInX {
                print("cards are correct")
            } else {
                print("cards are incorrect")
            }
        }
        
        if cards.near(gaps) {
            if cards.near(cards){
                self.run(SKAction.move(to: CGPoint(x: 300, y: 200), duration: 0.3))
            }
        }
        
        //Have cards stick to gaps
        if let index = self.near(gaps) {
            let stickAnimation = SKAction.move(to: CGPoint(x: gaps[index].position.x, y:gaps[index].position.y ), duration: 0.2)
            stickAnimation.timingMode = .easeOut
            self.run(stickAnimation)
        }
    }
}

