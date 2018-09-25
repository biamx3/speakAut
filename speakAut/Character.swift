//
//  Character.swift
//  speakAut
//
//  Created by Beatriz Melo Mousinho Magalhães on 31/08/18.
//  Copyright © 2018 Beatriz Melo Mousinho Magalhães. All rights reserved.
//

import UIKit

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
    var article: String = ""
    var subjectName: String = ""
    var sentenceArray: [Sentence] = []
    
    init(article: String, subjectName: String, sentenceArray: [Sentence]) {
        self.subjectName = subjectName
        self.article = article + " "
        self.sentenceArray = [Sentence(index: 0, cardArray: [], animation: "", sentenceNarration: "")]
    }
}
