//
//  Character.swift
//  speakAut
//
//  Created by Beatriz Melo Mousinho Magalhães on 31/08/18.
//  Copyright © 2018 Beatriz Melo Mousinho Magalhães. All rights reserved.
//

import UIKit
import SpriteKit

/**
 Model class for Character.
 
 *Values*
 
 `genericName` String that is the name of the character.
 
 `sentenceArray` Array of sentences each character has.
 
 - Author:
 Beatriz
 - Version:
 0.1
 */

class Character {
    var name: String = ""
    var article: String = ""
    var genericName: String = ""
    var sentenceArray: [Sentence] = []
    var hasEars: Bool = true
    var hasGlasses: Bool = false
    var firstCard: Card!
    
    init(name: String, hasEars: Bool, hasGlasses: Bool, article: String, genericName: String, sentenceArray: [Sentence]) {
        self.name = name
        self.hasEars = hasEars
        self.hasGlasses = hasGlasses
        self.genericName = genericName
        self.article = article + " "
        let firstWord = self.article + self.genericName
        firstCard = Card(index: 0, word: firstWord, imageName: "\(name)Profile", wordNarration: genericName)
        self.sentenceArray = [Sentence(animationSceneName: "", headTexture: "", index: 0, cardArray: [], sentenceNarration: "")]
    }
    
    func addProfileCard(){
        for sentence in self.sentenceArray{
            sentence.cardArray.insert(firstCard, at: 0)
        }
    }
    
    func addIdleAnimation(){
    sentenceArray[0].animationSceneName = "idle_\(name)"
    }
}


//  Add Ricardo Venieris
extension Array where Element == Character {
    func soundName(for characterNamed:String?)->String {
        guard let charName = characterNamed else {return ""}
        for element in self {
            if element.name == charName {
                return element.sentenceArray.first?.sentenceNarration ?? ""
            }
        }
        return ""
    }
}
