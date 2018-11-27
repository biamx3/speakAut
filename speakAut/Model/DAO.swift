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
            
            let yawnAnimation = "yawn"
            let danceAnimation = "danceSalsa"
            let waveAnimation = "wave"
            let listenToMusicAnimation = "listenToMusic"
            let clapAnimation = "clap"
            let singAnimation = "sing"
            
            let aMeninaBocejou = "aMeninaBocejou"
            let aMeninaDancou = "aMeninaDancou"
            let aMeninaAcenou = "aMeninaAcenou"
            let aMeninaEscutouMusica = "aMeninaEscutouMusica"
            let aMeninaBateuPalmas = "aMeninaBateuPalmas"
            let aMeninaCantouUmaMusica = "aMeninaCantouUmaMusica"
            
            let oMeninoBocejou = "aMeninaBocejou"
            let oMeninoDancou = "aMeninaDancou"
            let oMeninoAcenou = "aMeninaAcenou"
            let oMeninoEscutouMusica = "aMeninaEscutouMusica"
            let oMeninoCantouUmaMusica = "aMeninaCantouUmaMusica"
            let oMeninoBateuPalmas = "oMeninoBateuPalmas"

            
            //LUCIANA
            //_____________________________________________________
            
            //LUCIANA
            let luciana = Character(name: "luciana", hasEars: true, hasGlasses: false, article: "a", subjectName:"menina", sentenceArray: [])
            
            //Idle
            let lucianaSentence0 = Sentence(animationSceneName: "idle_luciana", index: 0, cardArray: [], sentenceNarration: aMeninaAcenou)
            let lucianaS0Card2 = Card(index: 1, word: "acenou", imageName: "luciana_acenou", wordNarration: "acenou")
            lucianaSentence0.cardArray.append(lucianaS0Card2)
            
            //A menina acenou
            let lucianaSentence1 = Sentence(animationSceneName: waveAnimation, index: 1, cardArray: [], sentenceNarration: aMeninaAcenou)
            let lucianaS1Card2 = Card(index: 1, word: "acenou", imageName: "luciana_acenou", wordNarration: "acenou")
            lucianaSentence1.cardArray.append(lucianaS1Card2)
            
            //A menina escutou música
            let lucianaSentence2 = Sentence(animationSceneName: listenToMusicAnimation, index: 2, cardArray: [], sentenceNarration: aMeninaEscutouMusica)
            let lucianaS2Card2 = Card(index: 1, word: "escutou", imageName: "luciana_escutou", wordNarration: "escutou")
            let lucianaS2Card3 = Card(index: 2, word: "música", imageName: "musica", wordNarration: "musica")
            lucianaSentence2.cardArray.append(contentsOf: [lucianaS2Card2, lucianaS2Card3])
            
            //A menina bocejou
            let lucianaSentence3 = Sentence(animationSceneName: yawnAnimation, index: 3, cardArray: [], sentenceNarration: aMeninaBocejou)
            let lucianaS3Card2 = Card(index: 1, word: "bocejou", imageName: "luciana_bocejou", wordNarration: "bocejou")
            lucianaSentence3.cardArray.append(lucianaS3Card2)
            
            //A menina bateu palmas
            let lucianaSentence4 = Sentence(animationSceneName: clapAnimation, index: 4, cardArray: [], sentenceNarration: aMeninaBateuPalmas)
            let lucianaS4Card2 = Card(index: 1, word: "bateu", imageName: "luciana_bateu", wordNarration: "bateu")
            let lucianaS4Card3 = Card(index: 2, word: "palmas", imageName: "luciana_palmas", wordNarration: "palmas")
            lucianaSentence4.cardArray.append(contentsOf: [lucianaS4Card2, lucianaS4Card3])
            
            //A menina dançou
            let lucianaSentence5 = Sentence(animationSceneName: danceAnimation, index: 5, cardArray: [], sentenceNarration: aMeninaDancou)
            let lucianaS5Card2 = Card(index: 1, word: "dançou", imageName: "luciana_dancou", wordNarration: "dancou")
            lucianaSentence5.cardArray.append(lucianaS5Card2)
            
            //A menina cantou uma música
            let lucianaSentence6 = Sentence(animationSceneName: singAnimation, index: 6, cardArray: [], sentenceNarration: aMeninaCantouUmaMusica)
            let lucianaS6Card2 = Card(index: 1, word: "cantou", imageName: "luciana_cantou", wordNarration: "dancou")
            let lucianaS6Card3 = Card(index: 2, word: "uma música", imageName: "musica", wordNarration: "umaMusica")
            lucianaSentence6.cardArray.append(contentsOf:[lucianaS6Card2, lucianaS6Card3])
            
            luciana.sentenceArray.append(contentsOf: [lucianaSentence0, lucianaSentence1, lucianaSentence2, lucianaSentence3, lucianaSentence4, lucianaSentence5, lucianaSentence6])
            
            self.characterArray.append(luciana)
            
            
            //ANDRESSA
            //_____________________________________________________
            
            let andressa = Character(name: "andressa", hasEars: false, hasGlasses: false, article: "a", subjectName:"menina", sentenceArray: [])
            
            //Idle
            let andressaSentence0 = Sentence(animationSceneName: "idle_andressa", index: 0, cardArray: [], sentenceNarration: aMeninaAcenou)
            let andressaS0Card2 = Card(index: 1, word: "acenou", imageName: "andressa_acenou", wordNarration: "acenou")
            andressaSentence0.cardArray.append(andressaS0Card2)
            
            //A menina acenou
            let andressaSentence1 = Sentence(animationSceneName: waveAnimation, index: 1, cardArray: [], sentenceNarration: aMeninaAcenou)
            let andressaS1Card2 = Card(index: 1, word: "acenou", imageName: "andressa_acenou", wordNarration: "acenou")
            andressaSentence1.cardArray.append(andressaS1Card2)

            
            //A menina escutou música
            let andressaSentence2 = Sentence(animationSceneName: listenToMusicAnimation, index: 2, cardArray: [], sentenceNarration: aMeninaEscutouMusica)
            let andressaS2Card2 = Card(index: 1, word: "escutou", imageName: "andressa_escutou", wordNarration: "escutou")
            let andressaS2Card3 = Card(index: 2, word: "música", imageName: "musica", wordNarration: "musica")
            andressaSentence2.cardArray.append(contentsOf: [andressaS2Card2, andressaS2Card3])
            
            //A menina bocejou
            let andressaSentence3 = Sentence(animationSceneName: yawnAnimation, index: 3, cardArray: [], sentenceNarration: aMeninaBocejou)
            let andressaS3Card2 = Card(index: 1, word: "bocejou", imageName: "andressa_bocejou", wordNarration: "bocejou")
            andressaSentence3.cardArray.append(andressaS3Card2)
            
            //A menina bateu palmas
            let andressaSentence4 = Sentence(animationSceneName: clapAnimation, index: 4, cardArray: [], sentenceNarration: aMeninaBateuPalmas)
            let andressaS4Card2 = Card(index: 1, word: "bateu", imageName: "andressa_bateu", wordNarration: "bateu")
            let andressaS4Card3 = Card(index: 2, word: "palmas", imageName: "andressa_palmas", wordNarration: "palmas")
            andressaSentence4.cardArray.append(contentsOf: [andressaS4Card2, andressaS4Card3])
            
            //A menina dançou
            let andressaSentence5 = Sentence(animationSceneName: danceAnimation, index: 5, cardArray: [], sentenceNarration: aMeninaDancou)
            let andressaS5Card2 = Card(index: 1, word: "dançou", imageName: "andressa_dancou", wordNarration: "dancou")
            andressaSentence5.cardArray.append(andressaS5Card2)
            
            //A menina cantou uma música
            let andressaSentence6 = Sentence(animationSceneName: singAnimation, index: 6, cardArray: [], sentenceNarration: aMeninaCantouUmaMusica)
            let andressaS6Card2 = Card(index: 1, word: "cantou", imageName: "andressa_cantou", wordNarration: "dancou")
            let andressaS6Card3 = Card(index: 2, word: "uma música", imageName: "musica", wordNarration: "umaMusica")
            andressaSentence6.cardArray.append(contentsOf:[andressaS6Card2, andressaS6Card3])
            
            andressa.sentenceArray.append(contentsOf: [andressaSentence0, andressaSentence1, andressaSentence2, andressaSentence3, andressaSentence4, andressaSentence5, andressaSentence6])
            
            self.characterArray.append(andressa)
            
            
            //HENRIQUE
            //_____________________________________________________
            
            let henrique = Character(name: "henrique", hasEars: true, hasGlasses: false, article: "o", subjectName:"menino", sentenceArray: [])
            
            //Idle
            let henriqueSentence0 = Sentence(animationSceneName: "idle_henrique", index: 0, cardArray: [], sentenceNarration: aMeninaAcenou)
            let henriqueS0Card2 = Card(index: 1, word: "acenou", imageName: "henrique_acenou", wordNarration: "acenou")
            henriqueSentence0.cardArray.append(henriqueS0Card2)
            
            //O menino acenou
            let henriqueSentence1 = Sentence(animationSceneName: waveAnimation, index: 1, cardArray: [], sentenceNarration: oMeninoAcenou)
            let henriqueS1Card2 = Card(index: 1, word: "acenou", imageName: "henrique_acenou", wordNarration: "acenou")
            henriqueSentence1.cardArray.append(henriqueS1Card2)
            
            //O menino escutou música
            let henriqueSentence2 = Sentence(animationSceneName: listenToMusicAnimation, index: 2, cardArray: [], sentenceNarration: oMeninoEscutouMusica)
            let henriqueS2Card2 = Card(index: 1, word: "escutou", imageName: "henrique_escutou", wordNarration: "escutou")
            let henriqueS2Card3 = Card(index: 2, word: "música", imageName: "musica", wordNarration: "musica")
            henriqueSentence2.cardArray.append(contentsOf: [henriqueS2Card2, henriqueS2Card3])
            
            //O menino bocejou
            let henriqueSentence3 = Sentence(animationSceneName: yawnAnimation, index: 3, cardArray: [], sentenceNarration: oMeninoBocejou)
            let henriqueS3Card2 = Card(index: 1, word: "bocejou", imageName: "henrique_bocejou", wordNarration: "bocejou")
            henriqueSentence3.cardArray.append(henriqueS3Card2)
            
            //O menino bateu palmas
            let henriqueSentence4 = Sentence(animationSceneName: clapAnimation, index: 4, cardArray: [], sentenceNarration: oMeninoBateuPalmas)
            let henriqueS4Card2 = Card(index: 1, word: "bateu", imageName: "henrique_bateu", wordNarration: "bateu")
            let henriqueS4Card3 = Card(index: 2, word: "palmas", imageName: "henrique_palmas", wordNarration: "palmas")
            henriqueSentence4.cardArray.append(contentsOf: [henriqueS4Card2, henriqueS4Card3])
            
            //O menino dançou
            let henriqueSentence5 = Sentence(animationSceneName: danceAnimation, index: 0, cardArray: [], sentenceNarration: oMeninoDancou)
            let henriqueS5Card2 = Card(index: 1, word: "dançou", imageName: "henrique_dancou", wordNarration: "dancou")
            henriqueSentence5.cardArray.append(henriqueS5Card2)
            
            //O menino cantou uma música
            let henriqueSentence6 = Sentence(animationSceneName: singAnimation, index: 6, cardArray: [], sentenceNarration: oMeninoCantouUmaMusica)
            let henriqueS6Card2 = Card(index: 1, word: "cantou", imageName: "henrique_cantou", wordNarration: "dancou")
            let henriqueS6Card3 = Card(index: 2, word: "uma música", imageName: "musica", wordNarration: "umaMusica")
            henriqueSentence6.cardArray.append(contentsOf:[henriqueS6Card2, henriqueS6Card3])
            
            henrique.sentenceArray.append(contentsOf: [henriqueSentence0, henriqueSentence1, henriqueSentence2, henriqueSentence3, henriqueSentence4, henriqueSentence5, henriqueSentence6])
            
            self.characterArray.append(henrique)
            
            
            //FRANCISCO
            //_____________________________________________________
            
            let francisco = Character(name: "francisco", hasEars: true, hasGlasses: true, article: "o", subjectName:"menino", sentenceArray: [])
            
            //Idle
            let franciscoSentence0 = Sentence(animationSceneName: "idle_francisco", index: 0, cardArray: [], sentenceNarration: oMeninoAcenou)
            let franciscoSS0Card2 = Card(index: 1, word: "acenou", imageName: "francisco_acenou", wordNarration: "acenou")
            franciscoSentence0.cardArray.append(franciscoSS0Card2)
            
            //O menino acenou
            let franciscoSentence1 = Sentence(animationSceneName: waveAnimation, index: 1, cardArray: [], sentenceNarration: oMeninoAcenou)
            let franciscoS1Card2 = Card(index: 1, word: "acenou", imageName: "francisco_acenou", wordNarration: "acenou")
            franciscoSentence1.cardArray.append(franciscoS1Card2)
            
            //O menino escutou música
            let franciscoSentence2 = Sentence(animationSceneName: listenToMusicAnimation, index: 2, cardArray: [], sentenceNarration: oMeninoEscutouMusica)
            let franciscoS2Card2 = Card(index: 1, word: "escutou", imageName: "francisco_escutou", wordNarration: "escutou")
            let franciscoS2Card3 = Card(index: 2, word: "música", imageName: "musica", wordNarration: "musica")
            franciscoSentence2.cardArray.append(contentsOf: [franciscoS2Card2, franciscoS2Card3])
            
            //O menino bocejou
            let franciscoSentence3 = Sentence(animationSceneName: yawnAnimation, index: 3, cardArray: [], sentenceNarration: oMeninoBocejou)
            let franciscoS3Card2 = Card(index: 1, word: "bocejou", imageName: "francisco_bocejou", wordNarration: "bocejou")
            franciscoSentence3.cardArray.append(franciscoS3Card2)
            
            //O menino bateu palmas
            let franciscoSentence4 = Sentence(animationSceneName: clapAnimation, index: 4, cardArray: [], sentenceNarration: oMeninoBateuPalmas)
            let franciscoS4Card2 = Card(index: 1, word: "bateu", imageName: "francisco_bateu", wordNarration: "bateu")
            let franciscoS4Card3 = Card(index: 2, word: "palmas", imageName: "francisco_palmas", wordNarration: "palmas")
            franciscoSentence4.cardArray.append(contentsOf: [franciscoS4Card2, franciscoS4Card3])
            
            //O menino dançou
            let franciscoSentence5 = Sentence(animationSceneName: danceAnimation, index: 0, cardArray: [], sentenceNarration: oMeninoDancou)
            let franciscoS5Card2 = Card(index: 1, word: "dançou", imageName: "francisco_dancou", wordNarration: "dancou")
            franciscoSentence5.cardArray.append(franciscoS5Card2)
            
            //O menino cantou uma música
            let franciscoSentence6 = Sentence(animationSceneName: singAnimation, index: 6, cardArray: [], sentenceNarration: oMeninoCantouUmaMusica)
            let franciscoS6Card2 = Card(index: 1, word: "cantou", imageName: "francisco_cantou", wordNarration: "dancou")
            let franciscoS6Card3 = Card(index: 2, word: "uma música", imageName: "musica", wordNarration: "umaMusica")
            franciscoSentence6.cardArray.append(contentsOf:[franciscoS6Card2, franciscoS6Card3])
            
            francisco.sentenceArray.append(contentsOf: [franciscoSentence0, franciscoSentence1, franciscoSentence2, franciscoSentence3, franciscoSentence4, franciscoSentence5, franciscoSentence6])
            
            self.characterArray.append(francisco)
            
            //First card is always profile card
            for character in characterArray {
                character.addProfileCard()
                character.addIdleAnimation()
            }
            
            return characterArray
        }
}

