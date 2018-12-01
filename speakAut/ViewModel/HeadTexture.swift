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
        if animationName.starts(with: "idle") {
            if animationName.contains("henrique") {
                self.title = "idle_andressa"
            } else {
                self.title = animationName
            }
            let idleTextures = [[1,2,3,1,1,1,1,1,1,1], [1,1,1,1,1,1,2,3,1,1,1,1,1,1,1], [3,1,2,3,1,1,1,1,1,1,1,1], [1,1,1,1,1,1,1,1,1,1,1,2,3,1,1,1,1,1,1,1], [2,3,1,1,1,1,1,1,1]]
            let chosenTexture = idleTextures.randomElement()
            for number in chosenTexture! {
                let name = title + "_" + String(number)
                let texture = SKTexture(imageNamed: name)
                self.animationTextures.append(texture)
            }
        }
    }
}

