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
        
        func createCharacters() -> [Character] {
            
            let luciana = Character(name: "luciana", hasEars: true, hasGlasses: true, article: "a", subjectName:"menina", sentenceArray: [])
            
            let lucianaSentence1 = Sentence(animationSceneName: "idle_luciana", index: 0, cardArray: [], sentenceNarration: "")
            let lucianaSentence2 = Sentence(animationSceneName: "idle_luciana", index: 1, cardArray: [], sentenceNarration: "")
            let lucianaSentence3 = Sentence(animationSceneName: "idle_luciana", index: 0, cardArray: [], sentenceNarration: "")
            let lucianaSentence4 = Sentence(animationSceneName: "idle_luciana", index: 1, cardArray: [], sentenceNarration: "")
            
            luciana.sentenceArray.append(contentsOf: [lucianaSentence1, lucianaSentence2, lucianaSentence3, lucianaSentence4])
            
            self.characterArray.append(luciana)
            
         
            let andressa = Character(name: "andressa", hasEars: true, hasGlasses: true, article: "a", subjectName:"menina", sentenceArray: [])
            
            let andressaSentence1 = Sentence(animationSceneName: "idle_luciana", index: 0, cardArray: [], sentenceNarration: "")
            let andressaSentence2 = Sentence(animationSceneName: "idle_luciana", index: 1, cardArray: [], sentenceNarration: "")
            let andressaSentence3 = Sentence(animationSceneName: "idle_luciana", index: 2, cardArray: [], sentenceNarration: "")
            let andressaSentence4 = Sentence(animationSceneName: "idle_luciana", index: 3, cardArray: [], sentenceNarration: "")
            
            andressa.sentenceArray.append(contentsOf: [andressaSentence1, andressaSentence2, andressaSentence3, andressaSentence4])
            
            self.characterArray.append(andressa)
            
            let henrique = Character(name: "henrique", hasEars: true, hasGlasses: true, article: "a", subjectName:"menina", sentenceArray: [])
            
            let henriqueSentence1 = Sentence(animationSceneName: "idle_luciana", index: 0, cardArray: [], sentenceNarration: "")
            let henriqueSentence2 = Sentence(animationSceneName: "idle_luciana", index: 1, cardArray: [], sentenceNarration: "")
            let henriqueSentence3 = Sentence(animationSceneName: "idle_luciana", index: 2, cardArray: [], sentenceNarration: "")
            let henriqueSentence4 = Sentence(animationSceneName: "idle_luciana", index: 3, cardArray: [], sentenceNarration: "")
            
            henrique.sentenceArray.append(contentsOf: [henriqueSentence1, henriqueSentence2, henriqueSentence3, henriqueSentence4])
            
            self.characterArray.append(henrique)
            
            let francisco = Character(name: "francisco", hasEars: true, hasGlasses: true, article: "a", subjectName:"menina", sentenceArray: [])
            
            let franciscoSentence1 = Sentence(animationSceneName: "idle_luciana", index: 0, cardArray: [], sentenceNarration: "")
            let franciscoSentence2 = Sentence(animationSceneName: "idle_luciana", index: 1, cardArray: [], sentenceNarration: "")
            let franciscoSentence3 = Sentence(animationSceneName: "idle_luciana", index: 2, cardArray: [], sentenceNarration: "")
            let franciscoSentence4 = Sentence(animationSceneName: "idle_luciana", index: 3, cardArray: [], sentenceNarration: "")
            
            henrique.sentenceArray.append(contentsOf: [franciscoSentence1, franciscoSentence2, franciscoSentence3, franciscoSentence4])
            
            self.characterArray.append(francisco)
            
            return characterArray

        }
}

