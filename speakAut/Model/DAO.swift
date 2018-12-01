//
//  DAO.swift
//  speakAut
//
//  Created by Beatriz Melo Mousinho Magalhães on 31/08/18.
//  Copyright © 2018 Beatriz Melo Mousinho Magalhães. All rights reserved.
//

import UIKit
import SceneKit

    private let _DAO = DAO()
    
    open class DAO{
        
        public class var sharedInstance: DAO{
            return _DAO
        }
        
        //To make it easier to pick a character throughout the app
        var characterArray: [Character] = []
        var chosenCharacter: CharacterViewModel!
        var chosenSentence: Sentence!
        var animationNode: SCNNode!
        var availableSentences: [Sentence]!
        
        
        func createCharacters() -> [Character] {
            
            let andressa = Character(name: "andressa", hasEars: false, hasGlasses: false, article: "a", subjectName:"menina", sentenceArray: [])
            let henrique = Character(name: "henrique", hasEars: true, hasGlasses: false, article: "o", subjectName:"menino", sentenceArray: [])
            let francisco = Character(name: "francisco", hasEars: true, hasGlasses: true, article: "o", subjectName:"menino", sentenceArray: [])
            let luciana = Character(name: "luciana", hasEars: true, hasGlasses: false, article: "a", subjectName:"menina", sentenceArray: [])
            
            self.characterArray.append(contentsOf: [andressa, francisco, luciana, henrique])
            
            self.waveAnimation()
            self.listenToMusicAnimation()
            self.yawnAnimation()
            self.clapAnimation()
            self.danceSalsa()
            self.sing()
        
            self.addProfileCard()
            
            self.characterArray.append(francisco)
            
            return characterArray
        }
        
        
        func addProfileCard(){
            //First card is always profile card
            for character in characterArray {
                character.addProfileCard()
                character.addIdleAnimation()
            }
        }
        
        func waveAnimation(){
            for character in characterArray {
                let sentence = Sentence(animationSceneName: "wave", headTexture: "idle_\(character.name)", index: 1, cardArray: [], sentenceNarration: "\(character.subjectName)_acenou")
                let card1 = Card(index: 1, word: "acenou", imageName: "\(character.name)_acenou", wordNarration: "acenou")
                sentence.cardArray.append(card1)
                character.sentenceArray.append(sentence)
            }
        }
        
        func listenToMusicAnimation(){
            for character in characterArray {
                let sentence = Sentence(animationSceneName: "listenToMusic", headTexture: "idle_\(character.name)", index: 2, cardArray: [], sentenceNarration: "\(character.subjectName)_escutouMusica")
                let card1 = Card(index: 1, word: "escutou", imageName: "\(character.name)_escutou", wordNarration: "escutou")
                let card2 = Card(index: 2, word: "uma música", imageName: "musica", wordNarration: "musica")
                sentence.cardArray.append(contentsOf: [card1, card2])
                character.sentenceArray.append(sentence)
            }
        }
        
        
        func yawnAnimation(){
            for character in characterArray {
                let sentence = Sentence(animationSceneName: "yawn", headTexture: "idle_\(character.name)", index: 3, cardArray: [], sentenceNarration: "\(character.subjectName)_bocejou")
                let card1 = Card(index: 1, word: "bocejou", imageName: "\(character.name)_bocejou", wordNarration: "bocejou")
                sentence.cardArray.append(card1)
                character.sentenceArray.append(sentence)
            }
        }

        func clapAnimation(){
            for character in characterArray {
                let sentence = Sentence(animationSceneName: "clap", headTexture: "idle_\(character.name)", index: 4, cardArray: [], sentenceNarration: "\(character.subjectName)_bateuPalmas")
                let card1 = Card(index: 1, word: "bateu palmas", imageName: "\(character.name)_bateuPalmas", wordNarration: "bateuPalmas")
                sentence.cardArray.append(card1)
                character.sentenceArray.append(sentence)
            }
        }

        
        func danceSalsa(){
            for character in characterArray {
                let sentence = Sentence(animationSceneName: "danceSalsa", headTexture: "idle_\(character.name)", index: 5, cardArray: [], sentenceNarration: "\(character.subjectName)_dancou")
                let card1 = Card(index: 1, word: "dançou", imageName: "\(character.name)_dancou", wordNarration: "dancou")
                sentence.cardArray.append(card1)
                character.sentenceArray.append(sentence)
            }
        }
        
        func sing(){
            for character in characterArray {
                let sentence = Sentence(animationSceneName: "sing", headTexture: "idle_\(character.name)", index: 6, cardArray: [], sentenceNarration: "\(character.subjectName)_cantouUmaMusica")
                let card1 = Card(index: 1, word: "cantou", imageName: "\(character.name)_cantou", wordNarration: "cantou")
                let card2 = Card(index: 2, word: "uma música", imageName: "musica", wordNarration: "musica")
                sentence.cardArray.append(contentsOf: [card1, card2])
                character.sentenceArray.append(sentence)
            }
        }
}
