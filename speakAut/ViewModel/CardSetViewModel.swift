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
    private var gaps: [GapViewModel] = []
    private var invisibleNode: SKSpriteNode!
    var cardType: CardType!
    
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
        setUpInvisibleNode()
        
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
        }
    }
    
    func setUpInvisibleNode() {
        let sceneSize = self.frame.size
        invisibleNode = SKSpriteNode(color: .clear, size: sceneSize)
        invisibleNode.isUserInteractionEnabled = false
        invisibleNode.zPosition = 20
    }
    
    
    func cardsAreRight(cardNodes: [CardViewModel]) {
        self.hideGaps()
        //Turn off user interaction
        self.addChild(invisibleNode)
        self.isUserInteractionEnabled = false
        
        let successLabel = successMessage()
        self.addChild(successLabel)
        self.animateCards(cards: cardNodes)
        self.addParticles()
        successLabel.run(self.labelAnimation(), completion: {
            successLabel.removeFromParent()
            //Turn off confetti
            if self.cardType == .GameScene {
            self.goToRepeatWordsScene()
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
        let sucessMessageLabel = SKLabelNode(text: "Você acertou!")
        sucessMessageLabel.name = "instructionsLabel"
        sucessMessageLabel.fontSize = 32
        sucessMessageLabel.fontColor = UIColor.pumpkinOrange
        sucessMessageLabel.zPosition = 15
        sucessMessageLabel.fontName = "PeachyKeenJF"
        
        if self.cardType == .GameScene {
            sucessMessageLabel.position = CGPoint(x: 0, y: sceneSize.height/2.7)
        } else {
            sucessMessageLabel.position = CGPoint(x: 0, y: sceneSize.height/2.7)
        }
        return sucessMessageLabel
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
    

    func hideGaps(){
        guard let brothers = self.parent?.allDescendants() else {return}
        let gapsInScreen = brothers.filter {($0.name?.starts(with: "gap") ?? false)}
        
        for gap in gapsInScreen {
            gap.alpha = 0
        }
    }
    
    //–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
    //GAMESCENE: WHEN CARDS ARE IN WRONG ORDER
    
    func errorMessage() -> SKLabelNode {
        let sceneSize = self.frame.size
        let errorMessage = SKLabelNode(text: "Tente novamente")
        errorMessage.name = "instructionsLabel"
        errorMessage.fontSize = 32
        errorMessage.fontName = "PeachyKeenJF"
        errorMessage.fontColor = UIColor.greyishBrown
        errorMessage.zPosition = 15
        errorMessage.name = "error message"
        errorMessage.position = CGPoint(x: 0, y: sceneSize.height/6.7)
        errorMessage.alpha = 0
        
        return errorMessage
    }
    
    func cardsAreWrong(cardNodes: [CardViewModel]){
        let errorLabel = errorMessage()
        self.addChild(errorLabel)
        
        //Turn off user interaction
        self.addChild(invisibleNode)
        self.isUserInteractionEnabled = false

        //Animate error label appearance
        let fadeIn = SKAction.fadeAlpha(to: 3.0, duration: 0.8)
        let wait = SKAction.wait(forDuration: 2.0)
        let fadeOut = SKAction.fadeOut(withDuration: 0.5)
        let animation = SKAction.sequence([fadeIn, wait,fadeOut])

        errorLabel.run(animation, completion: {
            errorLabel.removeFromParent()
            self.removeAllCardsFromGaps(cards: cardNodes)
            })
    }
    
    func randomRotation() -> SKAction {
        let randomAngle = Float.random(in: -0.5 ..< 0.5)
        let randomRotation = SKAction.rotate(byAngle: CGFloat(randomAngle), duration: 0.15)
        return randomRotation
    }
    
    func removeAllCardsFromGaps(cards: [CardViewModel]){
        //Animate cards moving out of gap
        let removeCardFromGap = SKAction.move(by: CGVector(dx: 0, dy: CGSize.card.height*1.1), duration: 0.2)
        let randomRotation = self.randomRotation()
        let removeCardFromGapGroup = SKAction.group([removeCardFromGap, randomRotation])
        removeCardFromGapGroup.timingMode = .easeOut
        
        for card in cards {
            card.run(removeCardFromGapGroup, completion: {
                //Turn on user interaction
                self.invisibleNode.removeFromParent()
                self.isUserInteractionEnabled = true
            })
        }
    }

    
    func goToRepeatWordsScene(){
        let parent = self.parent as! GameScene
        parent.goToRepeatWordsScene()
    }
    

    //–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //Filter all nodes in scene to identify gaps and cards
        guard let brothers = self.parent?.allDescendants() else {return}
        let cardsInScreen = brothers.filter {($0.name?.starts(with: "card") ?? false)}
        let gapsInScreen = brothers.filter {($0.name?.starts(with: "gap") ?? false)}
        
        let cardViews = cardsInScreen as! [CardViewModel]
        
        if self.cardType == .GameScene {
            //Check if cards are in the correct order when all gaps are filled
            if (cardViews as [SKNode]).near(gapsInScreen) {
                
                if cardViews.isOrderedInX {
                    cardsAreRight(cardNodes: cardViews)

                    
                    
                } else {
                    cardsAreWrong(cardNodes: cardViews)
                }
            }
        }
        
        if self.cardType == .RepeatWordsScene {
            if self.bigCards.count == self.cards.count {
                if self.bigCards == self.cards {
                    addParticles()
                    cardsAreRight(cardNodes: cardViews)
                    print("you tapped in the correct order")
                } else {
                    for card in self.cards {
                        card.repeatedCardsWrong()
                        self.bigCards = []
                    }
                    print("you tapped in the incorrect order")
                }
            }
        }
    }
}
