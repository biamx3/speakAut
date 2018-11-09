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

    convenience init() {
        let texture = SKTexture(imageNamed: "gap")
        self.init(texture: texture, color: .clear, size: CGSize.card)
    }
    
    //We need to override this to allow for class to work in SpriteKit Scene Builder
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    
    //Override this to allow Hero to have access all convenience init methods
    override init(texture: SKTexture?, color: UIColor, size: CGSize){
        super.init(texture: texture, color: color, size: size)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let brothers = self.parent?.allDescendants() else {return}
        let card = brothers.filter {($0.name?.starts(with: "card") ?? false)}
        let gaps = brothers.filter {($0.name?.starts(with: "gap") ?? false)}
//        for child in self.children {
//            if child.near(card) {
//               print("uhul")// self.run(SKAction.move(to: card[index].position, duration: 0.1))
//            }
//        }
    }
}
