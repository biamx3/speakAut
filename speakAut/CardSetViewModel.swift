//
//  CardSetViewModel.swift
//  speakAut
//
//  Created by Beatriz Melo Mousinho Magalhães on 06/11/18.
//  Copyright © 2018 Beatriz Melo Mousinho Magalhães. All rights reserved.
//

import UIKit
import SpriteKit

class CardSetViewModel: SKSpriteNode {
    
    private var gap1 = GapViewModel()
    private var gap2 = GapViewModel()
    private var gap3 = GapViewModel()
    private var card1: CardViewModel!
    private var card2: CardViewModel!
    private var card3: CardViewModel!
    
    init(cardSet: [Card]){
        super.init(texture: nil, color: .clear, size: CGSize.card)
        self.name = "setOfCardsAndGaps"
        self.isUserInteractionEnabled = true
        let numberOfCards = cardSet.count
        addCards(number: numberOfCards, cardSet: cardSet)
        addGaps(number: numberOfCards)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addCards(number: Int, cardSet: [Card]) {
        let sceneSize = self.parent?.frame.size
        
        card1 = CardViewModel(cardModel: cardSet[0])
        card2 = CardViewModel(cardModel: cardSet[1])
        
        card1.name = "card1"
        card2.name = "card2"
        
        switch number {
        case 3:
            card3 = CardViewModel(cardModel: cardSet[2])
            
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
        guard let brothers = self.parent?.allDescendants() else {return}
        let cards = brothers.filter {($0.name?.starts(with: "card") ?? false)}
        let gaps = brothers.filter {($0.name?.starts(with: "gap") ?? false)}
        let cardArray = cards as! [CardViewModel]
        
        
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let touchedNode = self.nodes(at: location)
        
        if touchedNode == cardArray {
            print("touchesEnded")
        }
        
//        if([card1 containsPoint: touchLocation])
//        {
//           print("touchesended")
//        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard let brothers = self.parent?.allDescendants() else {return}
//        let cards = brothers.filter {($0.name?.starts(with: "card") ?? false)}
//        let cardArray = cards as! [CardViewModel]
//
//
//        guard let touch = touches.first else { return }
//        let location = touch.location(in: self)
//        let touchedNode = self.nodes(at: location)
//
//        if touchedNode == cardArray {
//            print("touchesEnded")
//        }
//    }
             print("uhul")
        for touch in touches{

            let location = touch.location(in: self)
            let nodesAtLocation = self.nodes(at: location)
            
            for node in nodesAtLocation {
                
                let nodeName = node.name
                
                print("Node Name \(nodeName)")
                
            }
        }
    }
    
}
