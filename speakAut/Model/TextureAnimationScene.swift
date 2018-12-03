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
    
    init(characterName: String, animation: String) {
        super.init(size: CGSize(width: 400, height: 400))
        
        //Character skin
        let skinNode = SKSpriteNode(color: .clear, size: self.size)
        skinNode.position = CGPoint(x: self.size.width/2.0, y: self.size.height/2.0)
        skinNode.run(SKAction.rotate(toAngle: 3.14 , duration: 0))
        skinNode.texture = SKTexture(imageNamed:"headTexture_\(characterName)")
        
        //Texture that is animated
        let animationNode = SKSpriteNode(color: .clear, size: self.size)
        animationNode.position = CGPoint(x: self.size.width/2.0, y: self.size.height/2.0)
        animationNode.run(SKAction.rotate(toAngle: 3.14 , duration: 0))
        
        self.addChild(animationNode)
        self.addChild(skinNode)
        skinNode.zPosition = 1
        animationNode.zPosition = 10
        let textureArray = HeadTexture(animationName: animation).animationTextures
        let faceAnimation = SKAction.animate(with: textureArray, timePerFrame: 0.1)
        
        
        animationNode.run(SKAction.repeatForever(faceAnimation))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
