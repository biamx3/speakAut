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
    
    private var cards: [CardViewModel] = []
    private var gaps: [GapViewModel] = []
    private var invisibleNode: SKSpriteNode!
    var cardType: CardType!
    
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
    //CARDS ARE IN CORRECT ORDER
    
    func successMessage() -> SKLabelNode {
        let sceneSize = self.frame.size
        let sucessMessage = SKLabelNode(text: "Você acertou!")
        sucessMessage.name = "instructionsLabel"
        sucessMessage.fontSize = 32
        sucessMessage.fontColor = UIColor.greyishBrown
        sucessMessage.zPosition = 15
        sucessMessage.position = CGPoint(x: 0, y: sceneSize.height/2.7)
        return sucessMessage
    }
    
    func cardsAreRight(cardNodes: [CardViewModel]) {
        let successLabel = successMessage()
        self.addChild(successLabel)
        
        let parent = self.parent as! GameScene
        parent.gameSceneDelegate?.turnOnConfetti()
        
        //Turn off user interaction
        self.addChild(invisibleNode)
        self.isUserInteractionEnabled = false
        
        //Animate error label appearance
        let fadeIn = SKAction.fadeAlpha(to: 3.0, duration: 1.0)
        let wait = SKAction.wait(forDuration: 4.0)
        let fadeOut = SKAction.fadeOut(withDuration: 1.0)
        let animation = SKAction.sequence([wait,fadeOut])
        
        self.hideGaps()
        successLabel.run(fadeIn, completion: {
            self.prepareCardsForRepeatExercise(cards: cardNodes)
            successLabel.run(animation, completion: {
            successLabel.removeFromParent()
            parent.gameSceneDelegate?.turnOffConfetti()
            parent.goToRepeatWordsScene()
            })

        })
    }
    
    func prepareCardsForRepeatExercise(cards: [CardViewModel]){
        //Animate cards going to center of screen
        let prepareCards = SKAction.move(by: CGVector(dx: 0, dy: CGSize.card.height*0.5), duration: 0.2)
        prepareCards.timingMode = .easeOut
        
        for card in cards {
            card.run(prepareCards, completion: {
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
    
    func createConfettiParticles(){
        
    }
    
    //–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
    //WHEN CARDS ARE IN WRONG ORDER
    
    func errorMessage() -> SKLabelNode {
        let sceneSize = self.frame.size
        let errorMessage = SKLabelNode(text: "Tente novamente")
        errorMessage.name = "instructionsLabel"
        errorMessage.fontSize = 32
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
            
        }
    }
}
