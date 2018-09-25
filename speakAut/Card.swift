//
//  Card.swift
//  speakAut
//
//  Created by Beatriz Melo Mousinho Magalhães on 31/08/18.
//  Copyright © 2018 Beatriz Melo Mousinho Magalhães. All rights reserved.
//

import UIKit

/**
 Model class for Card.
 
 *Values*
 
  `word` The string displayed on a card.
 
 `imageName` The image displayed on a card.
 
 `wordNarration` The narration for each individual word. File name should be the same as imageName.
 
 `index` The number that determines the correct order of the cards: index1 < index2 < index3
 
 - Author:
 Beatriz
 - Version:
 0.1
 */

class Card {
    
    var word: String = ""
    var imageName: String = ""
    var wordNarration: String = ""
    var index: Int = 0
    
    init(index: Int, word: String, imageName: String, wordNarration: String) {
        self.word = word
        self.imageName = imageName
        self.wordNarration = wordNarration
        self.index = index
    }

}
