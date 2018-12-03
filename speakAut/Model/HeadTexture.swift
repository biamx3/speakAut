//
//  FaceTextures.swift
//  speakAut
//
//  Created by Beatriz Melo Mousinho Magalhães on 01/12/18.
//  Copyright © 2018 Beatriz Melo Mousinho Magalhães. All rights reserved.
//

import Foundation
import SpriteKit

struct HeadTexture {
    
    var title: String!
    var animationTextures: [SKTexture] = []
    
    init(animationName: String) {
        self.title = animationName
        var textures: [[Int]] = []
        
        switch title {
        case "idle":
            textures = [[1,2,3,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1], [1,1,1,1,1,1,2,3,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1], [3,1,2,3,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1], [1,1,1,1,1,1,1,1,1,1,1,2,3,1,1,1,1,1,1,1], [2,3,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]]
        case "happy":
            textures = [[1,2,6,1,2,6,3,3,3,3,3,3,3,3,3,3,3,3,6,6,6,6,6,6,6,6,6,6,6,6,2,1,1,3,3,3,3,3,3,3,3,3,3,6,6,6,6,6,6,6,2,2,1,1,6,6,6,6,6,6,6,6,6,6,6,6,6,1,2,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3]]
        case "sing":
            textures = [[3,4,5,4,5,3,1,6,7,6,7,6,7,6,8,6,8,1,2,3,4,3,4,3,4,3,4,3,5,3,2,1,6,8,7,6,7,8,3,3,3,3,3,3,3,4,5,3,2,1,1,1,1,1,6,7,8,8,8,8,8]]
        case "yawn":
            textures = [[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2,2,2,2,3,4,5,4,5,4,5,4,5,4,5,4,5,5,4,5,4,5,4,5,4,5,3,3,4,5,5,3,3,4,5,4,5,4,5,4,5,4,5,4,5,3,3]]
        case "listenToMusic":
            textures = [[1]]
        default:
            textures = [[1,2,3,4],[1,2,3,4],[1,2,3,4],[1,2,3,4]]
        }
        
        let chosenTexture = textures.randomElement()
        for number in chosenTexture! {
            let name = title + "_" + String(number)
            let texture = SKTexture(imageNamed: name)
            self.animationTextures.append(texture)
        }
    }
}

