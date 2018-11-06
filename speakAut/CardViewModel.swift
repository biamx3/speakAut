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

    var card = SKSpriteNode()
    var wordNode = SKLabelNode()
    var imageNode = SKSpriteNode()
    var isTouching = Bool()
    
    
    init(cardModel:Card) {
        let word = cardModel.word
        let image = cardModel.imageName
        super.init(texture: nil, color: .blue, size: CGSize.card)
        createCard()
        setUpCollision()
        self.wordNode.text = word
        imageNode.texture = SKTexture(imageNamed: image)
        self.name = word
        self.isUserInteractionEnabled = true
        self.zPosition = 15
        self.name = "card"
        isTouching = false
        self.addChild(card)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func imageSetUp() {
        self.imageNode = SKSpriteNode(color: .red, size: CGSize.cardImage)
        imageNode.zPosition = 5
        imageNode.position = CGPoint(x: 0, y: 20)
      //  imageNode.isUserInteractionEnabled = false
        imageNode.name = "cardChildImage"
        card.addChild(imageNode)
    }
    
    func wordSetUp() {
        self.wordNode = SKLabelNode(text: "word")
        wordNode.fontColor = UIColor.greyishBrown
        wordNode.fontSize = 32
        wordNode.position = CGPoint(x: 0, y: -125)
        wordNode.zPosition = 5
        wordNode.name = "cardChildWord"
    //   wordNode.isUserInteractionEnabled = false
        card.addChild(wordNode)
    }
    
    func setUpCollision() {
        self.physicsBody = SKPhysicsBody.init(rectangleOf: CGSize.card)
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.isDynamic = true
        self.physicsBody?.affectedByGravity = false
    }
    
    func cardSetUp() {
        self.card = SKSpriteNode(texture: SKTexture(imageNamed: "blankCard"))
      //  card.isUserInteractionEnabled = true
        card.zPosition = 4
        card.name = "cardParent"
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
        isTouching = true
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
        isTouching = false
        //checkSentences()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        isTouching = false 
    }
}



extension SKSpriteNode {
    func near(_ anotherNode:[SKSpriteNode?])->Int? {
        for i in 0..<anotherNode.count {
            //            print(i, "--->", self.position, "--->", anotherNodes[i]!.position)
            if let node = anotherNode[i] {
                if abs(self.position.x - node.position.x) < 30 &&
                    abs(self.position.y - node.position.y) < 30 {
                    return i
                }
            }
        }
        return nil
    }
}

extension SKNode {
    func isOneOf(_ nodes: [SKSpriteNode?])->Bool {
        for node in nodes {
            if self == node {
                return true
            }
        }
        return false
    }
}


extension UIColor {
    
    @nonobjc class var saffron: UIColor {
        return UIColor(red: 254.0 / 255.0, green: 187.0 / 255.0, blue: 13.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var robinSEgg: UIColor {
        return UIColor(red: 94.0 / 255.0, green: 231.0 / 255.0, blue: 1.0, alpha: 1.0)
    }
    
    @nonobjc class var brownGrey: UIColor {
        return UIColor(white: 151.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var azure: UIColor {
        return UIColor(red: 17.0 / 255.0, green: 191.0 / 255.0, blue: 234.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var deepOrange: UIColor {
        return UIColor(red: 227.0 / 255.0, green: 70.0 / 255.0, blue: 7.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var pumpkinOrange: UIColor {
        return UIColor(red: 1.0, green: 125.0 / 255.0, blue: 6.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var tealBlue: UIColor {
        return UIColor(red: 2.0 / 255.0, green: 125.0 / 255.0, blue: 167.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var marineBlue: UIColor {
        return UIColor(red: 2.0 / 255.0, green: 65.0 / 255.0, blue: 110.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var brownishGrey: UIColor {
        return UIColor(white: 110.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var greyishBrown: UIColor {
        return UIColor(white: 74.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var white: UIColor {
        return UIColor(white: 247.0 / 255.0, alpha: 1.0)
    }
    
}

extension CGSize {
    
    @nonobjc static var cardImage: CGSize {
        return CGSize(width: 235.0, height: 210.0)
    }
    @nonobjc static var card: CGSize {
        return CGSize(width: 267.0, height: 287.0)
    }
}

