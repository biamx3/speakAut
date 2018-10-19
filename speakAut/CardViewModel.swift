//
//  CardViewModel.swift
//  speakAut
//
//  Created by Beatriz Melo Mousinho Magalhães on 31/08/18.
//  Copyright © 2018 Beatriz Melo Mousinho Magalhães. All rights reserved.
//

import UIKit
import SpriteKit

class CardViewModel: SKScene {
    
    private var blankCard: SKSpriteNode! = nil
    
    override func didMove(to view: SKView) {
        self.blankCard = self.childNode(withName: "blankCard") as! SKSpriteNode
        self.blankCard.alpha = 0.5
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
}
