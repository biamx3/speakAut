//
//  Extensions.swift
//  speakAut
//
//  Created by Beatriz Melo Mousinho Magalhães on 06/11/18.
//  Copyright © 2018 Beatriz Melo Mousinho Magalhães. All rights reserved.
//

import Foundation
import SpriteKit

extension SKSpriteNode {
    func near(_ anotherNode:[SKSpriteNode?])->Int? {
        for i in 0..<anotherNode.count {
            //            print(i, "--->", self.position, "--->", anotherNodes[i]!.position)
            if let node = anotherNode[i] {
                if abs(self.position.x - node.position.x) < 30 &&
                    abs(self.position.y - node.position.y) < 30 {
                    return i
                }
            }
        }
        return nil
    }
}

extension SKNode {
    func isOneOf(_ nodes: [SKSpriteNode?])->Bool {
        for node in nodes {
            if self == node {
                return true
            }
        }
        return false
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
    
    @nonobjc class var white: UIColor {
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
