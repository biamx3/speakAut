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

    var index = 0
    
    convenience init() {
        let texture = SKTexture(imageNamed: "gap")
        self.init(texture: texture, color: .clear, size: CGSize.card)
        self.name = "gap"
        self.zPosition = 1
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }

    override init(texture: SKTexture?, color: UIColor, size: CGSize){
        super.init(texture: texture, color: color, size: size)
    }
}
