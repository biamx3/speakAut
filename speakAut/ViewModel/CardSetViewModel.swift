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
    
    //–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
    //GAMESCENE: CARDS ARE IN CORRECT ORDER
    
    func successMessage() -> SKLabelNode {
        let sceneSize = self.frame.size
        let sucessMessageLabel = SKLabelNode(text: "Você acertou!")
        sucessMessageLabel.name = "instructionsLabel"
        sucessMessageLabel.fontSize = 32
        sucessMessageLabel.fontColor = UIColor.pumpkinOrange
        sucessMessageLabel.zPosition = 15
        sucessMessageLabel.fontName = "PeachyKeenJF"
        sucessMessageLabel.position = CGPoint(x: 0, y: sceneSize.height/2.7)
        return sucessMessageLabel
    }
    
    
    func cardsAreRight(cardNodes: [CardViewModel]) {
        let successLabel = successMessage()
        self.addChild(successLabel)
    
        self.addParticles()
        
        //Turn off user interaction
        self.addChild(invisibleNode)
        self.isUserInteractionEnabled = false
        
        //Animate error label appearance
        let fadeIn = SKAction.fadeAlpha(to: 3.0, duration: 0.2)
        let scaleUp1 = SKAction.scale(to: 1.2, duration: 0.2)
        
        let groupFadeScale = SKAction.group([fadeIn, scaleUp1])
        
        let scaleDown1 = SKAction.scale(to: 0.9, duration: 0.2)
        let scaleUp2 = SKAction.scale(to: 1.3, duration: 0.3)
        let wait = SKAction.wait(forDuration: 6.0)
        
        let popAnimation = SKAction.sequence([groupFadeScale, scaleDown1, scaleUp2, wait])
    
        self.hideGaps()
        successLabel.run(fadeIn, completion: {
            self.prepareCardsForRepeatExercise(cards: cardNodes)
            successLabel.run(popAnimation, completion: {
            successLabel.removeFromParent()
            //Turn off confetti
            self.goToRepeatWordsScene()
            })

        })
    }
    
    func prepareCardsForRepeatExercise(cards: [CardViewModel]){
        let scaleUp1 = SKAction.scale(to: 1.2, duration: 0.1)
        let scaleDown1 = SKAction.scale(to: 0.9, duration: 0.1)
        let scaleUp2 = SKAction.scale(to: 1.3, duration: 0.2)
        
        let scaleSequence = SKAction.sequence([scaleUp1, scaleDown1])
        let move = SKAction.move(by: CGVector(dx: 0, dy: CGSize.card.height*0.5), duration: 0.2)
        let animation = SKAction.group([scaleSequence, move, scaleUp2])
        animation.timingMode = .easeInEaseOut
        
        //Animate cards going to center of screen
        for card in cards {
            card.run(animation, completion: {
                //MARK go to repeat scene
            })
        }
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
    

    func addParticles(){
        let wait = SKAction.wait(forDuration: 10.0)
        
        let sceneSize = UIScreen.main.bounds.size
        let textures = [SKTexture(imageNamed: "particle1"),SKTexture(imageNamed: "particle2"),SKTexture(imageNamed: "particle3")]
        
        for i in 0...textures.count - 1 {
            if let emitter = SKEmitterNode(fileNamed: "particle") {
                emitter.particleTexture = textures[i]
                emitter.position = CGPoint(x: 0, y: sceneSize.height)
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
