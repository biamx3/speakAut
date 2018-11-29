//
//  GameScene.swift
//  speakAut
//
//  Created by Beatriz Melo Mousinho Magalhães on 31/08/18.
//  Copyright © 2018 Beatriz Melo Mousinho Magalhães. All rights reserved.
//

import SpriteKit
import SceneKit

class GameScene: SKScene {

    weak var gameSceneDelegate: GameSceneDelegate?
    
    var cardSetViewModel: CardSetViewModel!
    var cardSet: [Card]!
    var cardType: CardType!
    var chosenCharacter: Character!

    private var invisibleNode: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        self.cardType = .GameScene
        self.setUpInvisibleNode()
        self.scaleMode = .resizeFill
        self.cardType = .GameScene
        addCardsAndGaps()
        addBackButton()
        self.isUserInteractionEnabled = false
        addInstructions()
    }
    
    func addInstructions(){
        let instructionsViewModel = InstructionsViewModel(cardType: .GameScene)
        instructionsViewModel.zPosition = 15
        self.addChild(instructionsViewModel)
    }
    
    func getRandomSentence() -> [Card] {
        var sentenceArray = DAO.sharedInstance.chosenCharacter.characterModel.sentenceArray
        //First sentence is always the idle animation
        sentenceArray.remove(at: 0)
        let sentence = sentenceArray.randomElement()
        DAO.sharedInstance.chosenSentence = sentence
        DAO.sharedInstance.animationNode = SCNScene(named: sentence?.animationSceneName ?? "idle_luciana", inDirectory: "art.scnassets", options: nil)?.rootNode
        return (sentence?.cardArray)!
    }
    
    func addCardsAndGaps(){
        self.cardSet = self.getRandomSentence()
        self.cardSetViewModel = CardSetViewModel(cardSet: cardSet, type: .GameScene)
        self.addChild(cardSetViewModel)
    }
    
    //Prints all nodes in node tree
    func printAllNodes(tab:String, node:SKNode) {
        let aTab = tab + "  "
        for child in node.children {
            print(aTab, child.name ?? "--- sem nome ---")
            printAllNodes(tab: aTab, node: child)
        }
    }
    
    func setUpInvisibleNode() {
        let sceneSize = self.frame.size
        invisibleNode = SKSpriteNode(color: .clear, size: sceneSize)
        invisibleNode.isUserInteractionEnabled = false
        invisibleNode.zPosition = 20
    }
    
    func randomRotation() -> SKAction {
        let randomAngle = Float.random(in: -0.3 ..< 0.3)
        let randomRotation = SKAction.rotate(byAngle: CGFloat(randomAngle), duration: 0.15)
        return randomRotation
    }

    override func update(_ currentTime: TimeInterval) {
        //Filter all nodes in scene to identify gaps and cards
        let brothers = self.allDescendants()
        let cards = brothers.filter {($0.name?.starts(with: "card") ?? false)}
        let cardArray = cards as! [CardViewModel]

        //Compare each card's position with the last card in the array
        for i in 0...cardArray.count - 1{
            let card = cardArray[i]
            let index = i
            let lastItem = cardArray.last
            let lastIndex = cardArray.index(of: lastItem ?? card)
            let nextCard = cardArray[lastIndex ?? 0]

            //Animate cards moving out of gap
            let removeCardFromGap = SKAction.move(by: CGVector(dx: 0, dy: 180), duration: 0.2)
            let randomRotation = self.randomRotation()
            let removeCardFromGapGroup = SKAction.group([removeCardFromGap, randomRotation])
            removeCardFromGapGroup.timingMode = .easeOut

            //If two cards have the same position, remove the card with the lowest zPosition from the gap
            if index != lastIndex && card.position == nextCard.position   {
                if card.zPosition < nextCard.zPosition {
                    print("remove")
                    card.run(removeCardFromGapGroup)
                } else {
                    nextCard.run(removeCardFromGapGroup)
                }
            }
        }
    }
    
    func addBackButton() {
        let sceneSize = UIScreen.main.bounds.size
        let backButtonTexture = SKTexture(imageNamed: "backButton")
        let touchArea = SKShapeNode(circleOfRadius: backButtonTexture.size().width*1.3)
        touchArea.strokeColor = .clear
        touchArea.name = "backButton"
        touchArea.position = CGPoint(x: -sceneSize.width/2.3 , y: sceneSize.height/2.4)
        let backButton = SKSpriteNode(texture: backButtonTexture, color: .clear, size: backButtonTexture.size())
        backButton.name = "backButton"
        touchArea.addChild(backButton)
        self.scene?.addChild(touchArea)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let position = touch.location(in: self)
        let touchedNode = atPoint(position)
        
        //Go to previous screen
        if touchedNode.name == "backButton" {
            touchedNode.run(SKAction.animateButton)
            self.gameSceneDelegate?.goToCharacterSelectionScreen()
        }
    }
    
    //–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
    //GAMESCENE: WHEN CARDS ARE IN WRONG ORDER
    
//    func errorMessage() -> SKLabelNode {
//        let sceneSize = self.frame.size
//        let errorMessage = SKLabelNode(text: "Tente novamente")
//        errorMessage.name = "instructionsLabel"
//        errorMessage.fontSize = 32
//        errorMessage.fontName = "PeachyKeenJF"
//        errorMessage.fontColor = UIColor.greyishBrown
//        errorMessage.zPosition = 15
//        errorMessage.name = "error message"
//        errorMessage.position = CGPoint(x: 0, y: sceneSize.height/6.7)
//        errorMessage.alpha = 0
//
//        return errorMessage
//    }
//
//    func cardsAreWrong(cardNodes: [CardViewModel]){
//        let errorLabel = errorMessage()
//        self.addChild(errorLabel)
//
//        //Turn off user interaction
//        self.addChild(invisibleNode)
//        self.isUserInteractionEnabled = false
//
//        //Animate error label appearance
//        let fadeIn = SKAction.fadeAlpha(to: 3.0, duration: 0.8)
//        let wait = SKAction.wait(forDuration: 2.0)
//        let fadeOut = SKAction.fadeOut(withDuration: 0.5)
//        let animation = SKAction.sequence([fadeIn, wait,fadeOut])
//
//        errorLabel.run(animation, completion: {
//            errorLabel.removeFromParent()
//            self.removeAllCardsFromGaps(cards: cardNodes)
//        })
//    }
//
//    func removeAllCardsFromGaps(cards: [CardViewModel]){
//        //Animate cards moving out of gap
//        let removeCardFromGap = SKAction.move(by: CGVector(dx: 0, dy: CGSize.card.height*1.1), duration: 0.2)
//        let randomRotation = self.randomRotation()
//        let removeCardFromGapGroup = SKAction.group([removeCardFromGap, randomRotation])
//        removeCardFromGapGroup.timingMode = .easeOut
//
//        for card in cards {
//            card.run(removeCardFromGapGroup, completion: {
//                //Turn on user interaction
//                self.invisibleNode.removeFromParent()
//                self.isUserInteractionEnabled = true
//            })
//        }
//    }
    
    func identifyCardsInScreen() -> [CardViewModel]! {
        let brothers = self.allDescendants()
        let cardsInScreen = brothers.filter {($0.name?.starts(with: "card") ?? false)}
        let cardViews = cardsInScreen as! [CardViewModel]
        return cardViews
    }
    
    func identifyGapsInScreen() -> [SKNode]! {
        let brothers = self.allDescendants()
        let gapsInScreen = brothers.filter {($0.name?.starts(with: "gap") ?? false)}
        let gapViews = gapsInScreen as! [GapViewModel]
        return gapViews
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let cardViews = self.identifyCardsInScreen()
        //let gapViews = self.identifyGapsInScreen()
        
        let brothers = self.allDescendants()
        let gapsInScreen = brothers.filter {($0.name?.starts(with: "gap") ?? false)}
        let gapViews = gapsInScreen as! [GapViewModel]
        
        if gapViews.isNear(cardViews!) {
            if cardViews!.isOrderedInX {
                print("correct order")
                self.cardSetViewModel.removeGaps()
                let celebrationViewModel = CelebrationViewModel(cardViewModel: cardViews!, cardType: .GameScene)
                self.addChild(celebrationViewModel)
            } else {
                let tryAgainViewModel = TryAgainViewModel(cardViewModel: cardViews!, cardType: .GameScene)
                self.addChild(tryAgainViewModel)
            }
        }
    }
    
}

protocol GameSceneDelegate: class {
    func goToRepeatWordsScene()
    func goToCharacterSelectionScreen()
}
