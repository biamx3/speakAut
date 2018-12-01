//
//  Extensions.swift
//  speakAut
//
//  Created by Beatriz Melo Mousinho Magalhães on 06/11/18.
//  Copyright © 2018 Beatriz Melo Mousinho Magalhães. All rights reserved.
//

import Foundation
import SpriteKit
import SceneKit

extension Array where Element == CardViewModel {
    func near(_ otherNodes:[SKNode?])-> Bool {
        for element in self {
            guard let _ = element.near(otherNodes) else { return false }
        }
        return true
    }
}


extension Array where Element == GapViewModel {
    func isNear(_ toCards:[CardViewModel])-> Bool {
        for element in self {
            guard let _ = element.near(toCards) else { return false }
        }
        return true
    }
}

//Animação de botões
extension SKAction {
        @nonobjc class var animateButton: SKAction {
            
        let scaleSmall = SKAction.scale(to: 0.9, duration: 0.08)
        let lowerOpacity = SKAction.fadeAlpha(to: 0.95, duration: 0.08)
        let smallAnimationGroup = SKAction.group([scaleSmall, lowerOpacity])
        
        let scaleBig = SKAction.scale(to: 1.0, duration: 0.05)
        let heightenOpacity = SKAction.fadeAlpha(to: 1.0, duration: 0.01)
        let bigAnimationGroup = SKAction.group([scaleBig, heightenOpacity])
        
        return SKAction.sequence([smallAnimationGroup, bigAnimationGroup])
    }
}

//Detecta se há um SKNode dentro de um range
extension SKNode {
    func near(_ otherNodes:[SKNode?])->Int? {
        for i in 0..<otherNodes.count {
            //            print(i, "--->", self.position, "--->", otherNodes[i]!.position)
            if let node = otherNodes[i] {
                if abs(self.position.x - node.position.x) < node.frame.size.width * 0.5 &&
                    abs(self.position.y - node.position.y) < node.frame.size.width * 0.5 {
                    return i
                }
            }
        }
        return nil
    }
    

    func allDescendants()->[SKNode] {
        var all:[SKNode] = []
        for child in self.children {
            all.append(child)
             all.append(contentsOf: child.allDescendants())
        }
            return all
    }
    
    func isOneOf(_ nodes: [SKSpriteNode?])->Bool {
        for node in nodes {
            if self == node {
                return true
            }
        }
        return false
    }
}

extension SCNNode {
    func allDescendants()->[SCNNode] {
        var all:[SCNNode] = []
        for child in self.childNodes {
            all.append(child)
            all.append(contentsOf: child.allDescendants())
        }
        return all
    }
    
    func animateTextures(nodeName: String, animation: String) {
        let scene = TextureAnimationScene(animation: animation)
        let mesh = self.childNode(withName: name ?? "head", recursively: true)
        //mesh?.geometry!.firstMaterial!.multiply.contents = scene
        //mesh?.geometry!.firstMaterial!.multiply.intensity = 0.7
        mesh?.geometry!.firstMaterial!.diffuse.contents = scene
    }
}

//Is it ordered in the X axis?
extension Array where Element == CardViewModel {
    var isOrderedInX:Bool {
        if self.count == 0 {return true}
        let previous = self.first!
        
        for element in self {
           if element != self.first {
                if previous.position.x > element.position.x {return false}
            }
        }
        return true
    }

    //A cada toque adicionar carta ao array; checar se o índice das cartas está na ordem certa. 
    
    
    //For repeatWordsScene: is it ordered in X and Scaled correctly?
    var isOrderedInXWithScale:Bool {
        if self.count == 0 {return true}
        let previous = self.first!
        
        for element in self {
            if element != self.first {
                if previous.position.x < element.position.x {
                    if previous.size.width < element.size.width {return false}
                }
            }
        }
        return true
    }
}

extension Array where Element == Int {
    var correctOrder:Bool {
        if self.count == 0 {return true}
        let previous = self.first!
        
        for element in self {
            if element == self.first { break }
            if element > previous {return false}
        }
        return true
    }
}

extension UIColor {
    
    @nonobjc class var saffron: UIColor {
        return UIColor(red: 254.0 / 255.0, green: 187.0 / 255.0, blue: 13.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var robinSEgg: UIColor {
        return UIColor(red: 94.0 / 255.0, green: 231.0 / 255.0, blue: 1.0, alpha: 1.0)
    }
    
    @nonobjc class var brownGrey: UIColor {
        return UIColor(white: 151.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var azure: UIColor {
        return UIColor(red: 17.0 / 255.0, green: 191.0 / 255.0, blue: 234.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var deepOrange: UIColor {
        return UIColor(red: 227.0 / 255.0, green: 70.0 / 255.0, blue: 7.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var pumpkinOrange: UIColor {
        return UIColor(red: 1.0, green: 125.0 / 255.0, blue: 6.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var tealBlue: UIColor {
        return UIColor(red: 2.0 / 255.0, green: 125.0 / 255.0, blue: 167.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var marineBlue: UIColor {
        return UIColor(red: 2.0 / 255.0, green: 65.0 / 255.0, blue: 110.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var brownishGrey: UIColor {
        return UIColor(white: 110.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var greyishBrown: UIColor {
        return UIColor(white: 74.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var whiteish: UIColor {
        return UIColor(white: 247.0 / 255.0, alpha: 1.0)
    }
    
}

extension CGSize {
    
    @nonobjc static var cardImage: CGSize {
        return CGSize(width: 235.0, height: 210.0)
    }
    @nonobjc static var card: CGSize {
        return CGSize(width: 267.0, height: 287.0)
    }
}

extension Int {
    var firstEven:Int {
        return  ( (self / 2) * 2) + 1
    }
    var cgFloat:CGFloat {
        return CGFloat(self)
    }
}

