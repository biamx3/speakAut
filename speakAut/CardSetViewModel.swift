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
    
    private var gaps: [GapViewModel] = []
    private var cards: [CardViewModel] = []
    
    init(cardSet: [Card]){
        super.init(texture: nil, color: .blue, size: UIScreen.main.bounds.size)
        self.name = "setOfCardsAndGaps"
        self.isUserInteractionEnabled = true
        let numberOfCards = cardSet.count
        addCards(cardSet: cardSet)
        addGaps(from: cards)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addCards(cardSet: [Card]) {
        let sceneSize = self.parent?.frame.size
        
        let cardMargin:CGFloat = 60
        let cardQnt = CGFloat(cardSet.count)
        let totalSpace = (CGSize.card.width * cardQnt) + (cardMargin * (cardQnt - 1))
        let totalSpaceLeftPosition = (sceneSize?.width ?? 0.0 / 2)  + (totalSpace / 2)
        //Navegar entre ímpares (1=1, 2=3, 3=3...)
        let firstCenter = totalSpace / CGFloat(((cardSet.count / 2) * 2) + 1) - cardMargin
        for i in 0..<cardSet.count {
            let cardView = CardViewModel(cardModel: cardSet[i])
            cardView.name = "card"
            let cardXPosition = totalSpaceLeftPosition + (firstCenter + cardMargin) * CGFloat(i + 1)
            cardView.position = CGPoint(x: cardXPosition, y: (sceneSize?.height ?? 0.0) + 180)
            self.addChild(cardView)
            cards.append(cardView)

        }
        
        
        
        
        default:
            card1.position = CGPoint(x: (sceneSize?.width ?? 0.0)/2 - 160, y: (sceneSize?.height ?? 0.0) + 180)
            card2.position = CGPoint(x: (sceneSize?.width ?? 0.0)/2 + 160, y: (sceneSize?.height ?? 0.0) + 180)
        }
        
        self.addChild(card1)
        self.addChild(card2)
    }
    
    func addGaps(number: Int) {
        let sceneSize = self.parent?.frame.size
        
        gap2 = GapViewModel()
        
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
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
     // print(type(of:self), #function)
        //Filter all nodes in scene to identify gaps and cards
        guard let brothers = self.parent?.allDescendants() else {return}
        let cards = [card1, ]
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
    }
}
