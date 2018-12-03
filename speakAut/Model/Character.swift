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
 
 `subjectName` String that is the name of the character.
 
 `sentenceArray` Array of sentences each character has.
 
 - Author:
 Beatriz
 - Version:
 0.1
 */

class Character {
    var name: String = ""
    var article: String = ""
    var subjectName: String = ""
    var sentenceArray: [Sentence] = []
    var hasEars: Bool = true
    var hasGlasses: Bool = false
    var firstCard: Card!
    
    init(name: String, hasEars: Bool, hasGlasses: Bool, article: String, subjectName: String, sentenceArray: [Sentence]) {
        self.name = name
        self.hasEars = hasEars
        self.hasGlasses = hasGlasses
        self.subjectName = subjectName
        self.article = article + " "
        let firstWord = self.article + self.subjectName
        firstCard = Card(index: 0, word: firstWord, imageName: "\(name)Profile", wordNarration: subjectName)
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
