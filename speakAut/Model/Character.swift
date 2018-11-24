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
    
    init(name: String, hasEars: Bool, hasGlasses: Bool, article: String, subjectName: String, sentenceArray: [Sentence]) {
        self.name = name
        self.hasEars = hasEars
        self.hasGlasses = hasGlasses
        self.subjectName = subjectName
        self.article = article + " "
        self.sentenceArray = [Sentence(animationSceneName: "", index: 0, cardArray: [], sentenceNarration: "")]
    }
}
