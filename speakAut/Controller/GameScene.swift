//
//  GameScene.swift
//  speakAut
//
//  Created by Beatriz Melo Mousinho Magalhães on 31/08/18.
//  Copyright © 2018 Beatriz Melo Mousinho Magalhães. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {

    weak var gameSceneDelegate: GameSceneDelegate?
    var cardSet: [Card]!
    var cardType: CardType!
    
    override func didMove(to view: SKView) {
        
        self.scaleMode = .resizeFill
        self.cardType = .GameScene
        addCardsAndGaps()
        printAllNodes(tab: "", node: self.scene!)
        addBackButton()
        self.isUserInteractionEnabled = true
        addInstructions()
    }
    
    func addInstructions(){
        let instructionsViewModel = InstructionsViewModel(cardType: .GameScene)
        self.addChild(instructionsViewModel)
    }
    
    func addCardsAndGaps(){
        let dao = DAO()
        let character = dao.createCharacter()
        let sentence = character.sentenceArray[0]
        self.cardSet = sentence.cardArray
        let cardSetViewModel = CardSetViewModel(cardSet: cardSet, type: .GameScene)
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
    
    func goToRepeatWordsScene(){
        let transition = SKTransition.reveal(with: .left, duration: 0.8)
        if let nextScene = RepeatWordsScene(fileNamed: "RepeatWordsScene") {
            nextScene.cardSet = self.cardSet
            nextScene.scaleMode = .aspectFill
            self.scene?.view?.presentScene(nextScene, transition: transition)
        }
    }
}


protocol GameSceneDelegate: class {
    func goToCharacterSelectionScreen()
}
