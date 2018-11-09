//
//  CardSetViewModel.swift
//  speakAut
//
//  Created by Beatriz Melo Mousinho Magalhães on 06/11/18.
//  Copyright © 2018 Beatriz Melo Mousinho Magalhães. All rights reserved.
//

import UIKit
import SpriteKit

class CardSetViewModel: SKNode {
    
    private var gap1 = GapViewModel()
    
    init(cardSet: [Card]){
        super.init()
        self.name = "setOfCardsAndGaps"
        self.isUserInteractionEnabled = false
        let numberOfCards = cardSet.count
        addCards(number: numberOfCards, cardSet: cardSet)
        addGaps(number: numberOfCards)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addCards(number: Int, cardSet: [Card]) {
        let sceneSize = self.parent?.frame.size
        
        let card1 = CardViewModel(cardModel: cardSet[0])
        let card2 = CardViewModel(cardModel: cardSet[1])
        
        card1.name = "card1"
        card2.name = "card2"
        
        switch number {
        case 3:
            let card3 = CardViewModel(cardModel: cardSet[2])
            
            card3.name = "card3"
            
            card1.position = CGPoint(x: (sceneSize?.width ?? 0.0)/2 - 310, y: (sceneSize?.height ?? 0.0) + 180)
            card2.position = CGPoint(x: (sceneSize?.width ?? 0.0)/2, y: (sceneSize?.height ?? 0.0) + 180)
            card3.position = CGPoint(x: (sceneSize?.width ?? 0.0)/2 + 310, y: (sceneSize?.height ?? 0.0) + 180)
            
            self.addChild(card3)
            
        default:
            card1.position = CGPoint(x: (sceneSize?.width ?? 0.0)/2 - 160, y: (sceneSize?.height ?? 0.0) + 180)
            card2.position = CGPoint(x: (sceneSize?.width ?? 0.0)/2 + 160, y: (sceneSize?.height ?? 0.0) + 180)
        }
        
        self.addChild(card1)
        self.addChild(card2)
    }
    
    func addGaps(number: Int) {
        let sceneSize = self.parent?.frame.size
        
        let gap2 = GapViewModel()
        
        gap1.name = "gap1"
        gap2.name = "gap2"
        
        switch number {
        case 3:
            let gap3 = GapViewModel()
            
            gap3.name = "gap3"
            
            gap1.position = CGPoint(x: (sceneSize?.width ?? 0.0)/2 - 310, y:  (sceneSize?.height ?? 0.0) - 180)
            gap2.position = CGPoint(x: (sceneSize?.width ?? 0.0)/2, y: (sceneSize?.height ?? 0.0) - 180)
            gap3.position = CGPoint(x: (sceneSize?.width ?? 0.0)/2 + 310, y: (sceneSize?.height ?? 0.0) - 180)
            
            self.addChild(gap3)
            
        default:
            gap1.position = CGPoint(x: (sceneSize?.width ?? 0.0)/2 - 160, y: (sceneSize?.height ?? 0.0) - 180)
            gap2.position = CGPoint(x: (sceneSize?.width ?? 0.0)/2 + 160, y: (sceneSize?.height ?? 0.0) - 180)
        }
        
        self.addChild(gap1)
        self.addChild(gap2)
    }
    
    func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
