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
    
    init(cardSet: [Card]){
        super.init(texture: nil, color: .clear, size: UIScreen.main.bounds.size)
        self.name = "setOfCardsAndGaps"
        self.isUserInteractionEnabled = true

        addCards(from: cardSet)
        addGaps(from: cards)
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
            let cardView = CardViewModel(cardModel: cardSet[i])
            
            let cardXPosition = firstXposition + (cardConstantSpacing * i.cgFloat)
            cardView.position = CGPoint(x: cardXPosition, y: (sceneSize?.height ?? 0.0) + 180)

            self.addChild(cardView)
            cards.append(cardView)

        }
    }
    
    func addGaps(from cards: [CardViewModel]) {
        let sceneSize = self.parent?.frame.size
        
        for card in cards {
            let gap = GapViewModel()
            gap.position = CGPoint(x: card.position.x, y:  (sceneSize?.height ?? 0.0) - 180)
            self.addChild(gap)

        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
     // print(type(of:self), #function)
        
        //Check if cards are in the correct order when all gaps are filled
        if (cards as [SKNode]).near(gaps) {
            if cards.isOrderedInX {
                print("cards are correct")
            } else {
                print("cards are incorrect")
            }
        }
    }
}
