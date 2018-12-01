//
//  FaceTextures.swift
//  speakAut
//
//  Created by Beatriz Melo Mousinho Magalhães on 01/12/18.
//  Copyright © 2018 Beatriz Melo Mousinho Magalhães. All rights reserved.
//

import Foundation
import SpriteKit

struct HeadTextures {
    
    var animationName: String!
    var animationTextures: [SKTexture] = []
    
    init(animationName: String) {
        switch animationName {
        case "idle_andressa":
            self.animationTextures = [SKTexture(imageNamed: "\(animationName)_1"), SKTexture(imageNamed: "\(animationName)_2"), SKTexture(imageNamed: "\(animationName)_3")]
            
        case "idle_henrique":
            self.animationTextures = [SKTexture(imageNamed: "idle_andressa_1"), SKTexture(imageNamed: "idle_andressa_2"), SKTexture(imageNamed: "idle_andressa_3")]
            
        case "idle_francisco":
            self.animationTextures = [SKTexture(imageNamed: "\(animationName)_1"), SKTexture(imageNamed: "\(animationName)_2"), SKTexture(imageNamed: "\(animationName)_3")]
        
        case "idle_luciana":
            self.animationTextures = [SKTexture(imageNamed: "\(animationName)_1"), SKTexture(imageNamed: "\(animationName)_2"), SKTexture(imageNamed: "\(animationName)_3")]
            
        default:
            break
        }
    }
}
