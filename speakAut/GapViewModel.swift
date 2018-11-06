//
//  GapViewModel.swift
//  speakAut
//
//  Created by Beatriz Melo Mousinho Magalhães on 06/11/18.
//  Copyright © 2018 Beatriz Melo Mousinho Magalhães. All rights reserved.
//

import UIKit
import SpriteKit

class GapViewModel: SKSpriteNode {
    
    var gapTexture = SKSpriteNode()
    
    init(){
        super.init(texture: SKTexture(imageNamed: "gap"), color: .blue, size: CGSize.card)
    }
    
    init(numberOfGaps: Int){
        super.init(texture: SKTexture(imageNamed: "gap"), color: .blue, size: CGSize.card)
        self.zPosition = 15
        gapSetUp()
        addGaps(number: numberOfGaps)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func gapSetUp() {
        self.gapTexture = SKSpriteNode(texture: SKTexture(imageNamed: "gap"))
        self.gapTexture.size = CGSize.card
    }
    
    func addGaps(number: Int) {
        switch number {
        case 2:
            let gap1 = GapViewModel()
            let gap2 = GapViewModel()
                
            gap1.position = CGPoint(x: 180.0, y: -160.0)
            gap2.position = CGPoint(x: -150.0, y: -160.0)
            
            (self.parent ?? self).addChild(gap1)
            (self.parent ?? self).addChild(gap2)
        
        case 3:
            let gap1 = GapViewModel()
            let gap2 = GapViewModel()
            let gap3 = GapViewModel()
            
            let sceneSize = self.parent?.frame.size
            
            gap1.position = CGPoint(x: -190.0, y: -160.0)
            gap2.position = CGPoint(x: (sceneSize?.width ?? 0.0)/2, y: (sceneSize?.height ?? 0.0) - 30)
            gap3.position = CGPoint(x: -150.0, y: -160.0)
            
          //  (self.parent ?? self).addChild(gap1)
          //  (self.parent ?? self).addChild(gap2)
            (self.parent ?? self).addChild(gap3)
        default:
            break
        }
    }
    
    func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
