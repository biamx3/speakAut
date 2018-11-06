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
    
    private var gapTexture = SKSpriteNode()
    private var sceneSize = CGSize()
    
    init(){
        super.init(texture: SKTexture(imageNamed: "gap"), color: .clear, size: CGSize.card)
    }
    
    init(numberOfGaps: Int){

        super.init(texture: nil, color: .blue, size: CGSize(width: CGSize.card.width*3, height: CGSize.card.height))
        self.zPosition = 2
        self.name = "setOfGaps"
        let sceneSize = self.parent?.frame.size
        self.size.width = sceneSize?.width ?? CGSize.card.width
        self.position = CGPoint(x: (sceneSize?.width ?? 0.0)/2, y: (sceneSize?.height ?? 0.0) - 180)
        gapSetUp()
        setUpCollisions()
        addGaps(number: numberOfGaps)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func gapSetUp() {
        self.gapTexture = SKSpriteNode(texture: SKTexture(imageNamed: "gap"))
        self.gapTexture.size = CGSize.card
    }
    
    func setUpCollisions(){
        for child in self.children {
            child.physicsBody?.categoryBitMask = UInt32.gapCategory
            child.physicsBody?.contactTestBitMask = UInt32.cardCategory
            child.physicsBody?.collisionBitMask = 0
            child.physicsBody?.isDynamic = false
        }
    }
    
    func addGaps(number: Int) {
        let sceneSize = self.parent?.frame.size
        
        let gap1 = GapViewModel()
        let gap2 = GapViewModel()
        
        gap1.name = "gap1"
        gap2.name = "gap2"
        
        switch number {
        case 3:
            let gap3 = GapViewModel()
            
            gap3.name = "gap3"
            
            gap1.position = CGPoint(x: (sceneSize?.width ?? 0.0)/2 - 310, y: 0)
            gap2.position = CGPoint(x: (sceneSize?.width ?? 0.0)/2, y: 0)
            gap3.position = CGPoint(x: (sceneSize?.width ?? 0.0)/2 + 310, y: 0)
            
            self.addChild(gap3)
            
        default:
            gap1.position = CGPoint(x: (sceneSize?.width ?? 0.0)/2 - 160, y: 0)
            gap2.position = CGPoint(x: (sceneSize?.width ?? 0.0)/2 + 160, y: 0)
        }
    
        self.addChild(gap1)
        self.addChild(gap2)
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
    
    func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
