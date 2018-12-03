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
        case "sing":
            textures = [[1,1,1,1,2,1,1,2,1,2,1,1,2,1,2,1,1,2,1,1,1,1,1,1,1,2,3,4,3,4,1,2,1,1,2,3,4,3,4,3,4,2,1], [4,4,3,3,2,1,1,1,2,1,1,2,1,2,1,1,2,1,2,1,1,2,1,1,2,3,4,3,4,1,2,1,1,2,3,4,3,4,3,4,2,1], [3,3,3,3,2,1,1,1,1,2,1,1,2,1,2,1,1,2,1,2,1,1,2,1,2,1,1,2,1,2,3,4,3,4,1,2,1,1,2,3,4,3,4,3,4,2,1]]
        case "yawn":
            textures = [[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2,2,2,2,3,4,5,4,5,4,5,4,5,4,5,4,5,5,4,5,4,5,4,5,4,5,3,3,4,5,5,3,3,4,5,4,5,4,5,4,5,4,5,4,5,3,3]]
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

