//
//  BodyTexture.swift
//  speakAut
//
//  Created by Beatriz Melo Mousinho Magalhães on 01/12/18.
//  Copyright © 2018 Beatriz Melo Mousinho Magalhães. All rights reserved.
//

import UIKit
import SpriteKit

class StaticTexture: SKScene {
    
    //Body parts are body or ear
    init(characterName: String, bodyPart: String) {
        super.init(size: CGSize(width: 400, height: 400))
        let title: String = "\(bodyPart)Texture_\(characterName)"
        let texture = SKTexture(imageNamed: title)
        let backgroundNode = SKSpriteNode(texture: texture, color: .clear, size: texture.size())
        self.size = texture.size()
        backgroundNode.position = CGPoint(x: self.size.width/2.0, y: self.size.height/2.0)
        backgroundNode.run(SKAction.rotate(toAngle: 3.14 , duration: 0))
        self.addChild(backgroundNode)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
