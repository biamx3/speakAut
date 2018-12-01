//
//  TextureAnimationScene.swift
//  speakAut
//
//  Created by Beatriz Melo Mousinho Magalhães on 01/12/18.
//  Copyright © 2018 Beatriz Melo Mousinho Magalhães. All rights reserved.
//

import UIKit
import SpriteKit

class TextureAnimationScene: SKScene {
    
    init(animation: String) {
        super.init(size: CGSize(width: 300, height: 300))
        let backgroundNode = SKSpriteNode(color: UIColor.blue, size: self.size)
        backgroundNode.position = CGPoint(x: self.size.width/2.0, y: self.size.height/2.0)
        backgroundNode.run(SKAction.rotate(toAngle: 3.14 , duration: 0))
        self.addChild(backgroundNode)
        
        let textureArray = HeadTexture(animationName: animation).animationTextures
        let faceAnimation = SKAction.animate(with: textureArray, timePerFrame: 0.1)
        
        
        backgroundNode.run(SKAction.repeatForever(faceAnimation))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
