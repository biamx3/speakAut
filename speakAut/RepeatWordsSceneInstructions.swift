//
//  RepeatWordsSceneInstructions.swift
//  speakAut
//
//  Created by Beatriz Melo Mousinho Magalhães on 22/11/18.
//  Copyright © 2018 Beatriz Melo Mousinho Magalhães. All rights reserved.
//

import UIKit
import SpriteKit

class RepeatWordsSceneInstructions: SKScene {

    override func didMove(to view: SKView) {
        
        self.scaleMode = .resizeFill
        self.isUserInteractionEnabled = true
        
        var instructionsLabel = self.childNode(withName: "instructionsLabel") as! SKLabelNode
        instructionsLabel.preferredMaxLayoutWidth = self.view?.bounds.size.width ?? 300 * 0.8
        
        let wait = SKAction.wait(forDuration: 1)
        self.run(wait, completion: {
            
        })
        
    }
    
    func goToGameScene(){
        
    }
}
