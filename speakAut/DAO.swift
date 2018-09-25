//
//  DAO.swift
//  speakAut
//
//  Created by Beatriz Melo Mousinho Magalhães on 31/08/18.
//  Copyright © 2018 Beatriz Melo Mousinho Magalhães. All rights reserved.
//

import UIKit

    private let _DAO = DAO()
    
    open class DAO{
        
        public class var sharedInstance: DAO{
            return _DAO
        }
        
        var characterArray: [Character] = []
        
        func getCharacter()  {
//            let character1 = Character(article: "A", subjectName: "menina", sentenceArray: [Sentence(index: 0, cardArray: [Card(index: 0, word: "dsd" , imageName: "imagem 0", wordNarration: "audio da palavra 0"), Card(index: 1, word: "dançou", imageName: "imagem 1", wordNarration: "audio da palavra 1"), Card(index: 0, word: "A menina", imageName: "imagem 0", wordNarration: "audio da palavra 0")], animation: "animation 1", sentenceNarration: "sentence Narration")])
            
            //A menina
            let character1 = Character(article: "a", subjectName: "menina", sentenceArray: [])
            
            //dançou sozinha
            character1.sentenceArray.append(Sentence(index: 0, cardArray: [], animation: "hello", sentenceNarration: "hello"))
            character1.sentenceArray[0].cardArray.append(Card(index: 0, word: "a menina", imageName: "menina", wordNarration: "lala"))
            character1.sentenceArray[0].cardArray.append(Card(index: 1, word: "dançou", imageName: "dancou", wordNarration: "dancou"))
            character1.sentenceArray[0].cardArray.append(Card(index: 2, word: "sozinha", imageName: "sozinha", wordNarration: "sozinha"))
            
            characterArray.append(character1)

        }

    }

