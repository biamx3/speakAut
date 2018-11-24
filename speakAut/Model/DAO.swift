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
        
//        func getFinishedCards(characterIndex: Int, sentenceIndex: Int) -> Sentence {
//            let sentence = characterArray[characterIndex].sentenceArray[sentenceIndex]
//            return sentence
//        }
        
        
        func getFinishedCards(characterIndex: Int, sentenceIndex: Int) -> Sentence {
            let sentence = characterArray[characterIndex].sentenceArray[sentenceIndex]
            return sentence
        }
        
        func createCharacter() -> Character {
            
            
            let luciana = Character(name: "Luciana", hasEars: true, hasGlasses: true, article: "a", subjectName:"menina", sentenceArray: [])
            
            let sentence = Sentence(animationSceneName: "idle_luciana", index: 0, cardArray: [], sentenceNarration: "")
            let sentence2 = Sentence(animationSceneName: "idle_luciana", index: 1, cardArray: [], sentenceNarration: "")
            
            luciana.sentenceArray.append(contentsOf: [sentence, sentence2])
            
            self.characterArray.append(luciana)
            
            
//            let character1 = Character(name: "Luciana", hasEars: true, hasGlasses: false, article: "a", subjectName: "menina", sentenceArray: [])
//
//            //dançou sozinha
//            character1.sentenceArray.append(Sentence(sceneName: "idle_luciana", index: 0, cardArray: [], animation: "hello", sentenceNarration: "hello"))
//            character1.sentenceArray[0].cardArray.append(Card(index: 0, word: "a menina", imageName: "menina", wordNarration: "lala"))
//            character1.sentenceArray[0].cardArray.append(Card(index: 1, word: "dançou", imageName: "dancou", wordNarration: "dancou"))
//
//            character1.sentenceArray.append(Sentence(sceneName: "idle_luciana", index: 1, cardArray: [], animation: "hello", sentenceNarration: "hello"))
//            character1.sentenceArray[0].cardArray.append(Card(index: 0, word: "a menina", imageName: "menina", wordNarration: "lala"))
//            character1.sentenceArray[0].cardArray.append(Card(index: 1, word: "dançou", imageName: "dancou", wordNarration: "dancou"))
            
            return luciana

        }
}

