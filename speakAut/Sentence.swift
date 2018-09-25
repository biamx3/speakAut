//
//  Sentence.swift
//  speakAut
//
//  Created by Beatriz Melo Mousinho Magalhães on 31/08/18.
//  Copyright © 2018 Beatriz Melo Mousinho Magalhães. All rights reserved.
//

import UIKit

/**
 Model class for Sentence.
 
 *Values*
 
 `index`
 
 `sentence` Concatenation of card words
 
  `animation` The name of the animation of the sentence
 
  `cardArray` An array of cards contained in the sentence
 
 `sentenceNarration` The narration for the whole sentence
 
 
 - Author:
 Beatriz
 - Version:
 0.1
 */

class Sentence {
    
    var index : Int = 0
    var animation : String = ""
    var cardArray : [Card] = []
    var sentenceNarration: String = ""

    
    init(index: Int, cardArray: [Card], animation: String, sentenceNarration: String) {
        self.index = index
        self.cardArray = cardArray
        self.animation = animation
        self.sentenceNarration = sentenceNarration

    }
}
