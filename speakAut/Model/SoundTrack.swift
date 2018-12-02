//
//  SoundTrack.swift
//  WWDC17
//
//  Created by Beatriz Melo Mousinho Magalhães on 3/29/17.
//  Copyright © 2017 Beatriz. All rights reserved.
//

import Foundation
import AVFoundation

private let _SoundTrack = SoundTrack()

open class SoundTrack{
    
    public class var sharedInstance: SoundTrack{
        return _SoundTrack
    }
 
var player: AVAudioPlayer?
var wordPlayer: AVAudioPlayer?
var onoPlayer: AVAudioPlayer?
var instructionsPlayer: AVAudioPlayer?
var musicPlayer: AVAudioPlayer?

    func stopSound(){
        self.player?.stop()
    }
    
    func stopOno(){
        self.onoPlayer?.stop()
    }
    
    func playSound(withName: String) {
        let url = Bundle.main.url(forResource: withName, withExtension: "wav")!
        do {
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            
            player.prepareToPlay()
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
        
    }
    
    func playWord(withName: String) {
        let url = Bundle.main.url(forResource: withName, withExtension: "wav")!
        do {
            wordPlayer = try AVAudioPlayer(contentsOf: url)
            guard let wordPlayer = wordPlayer else { return }
            
            wordPlayer.prepareToPlay()
            wordPlayer.play()
        } catch let error {
            print(error.localizedDescription)
        }
        
    }
    
    func playOno(withName: String) {
        let url = Bundle.main.url(forResource: withName, withExtension: "wav")!
        do {
            onoPlayer = try AVAudioPlayer(contentsOf: url)
            guard let onoPlayer = onoPlayer else { return }
            
            onoPlayer.volume = 0.3
            
            onoPlayer.prepareToPlay()
            onoPlayer.play()
        } catch let error {
            print(error.localizedDescription)
        }
       onoPlayer?.numberOfLoops = -1
    }
    
    func playInstructions(withName: String) {
        let url = Bundle.main.url(forResource: withName, withExtension: "wav")!
        do {
            instructionsPlayer = try AVAudioPlayer(contentsOf: url)
            guard let instructionsPlayer = instructionsPlayer else { return }
            
            instructionsPlayer.prepareToPlay()
            instructionsPlayer.play()
        } catch let error {
            print(error.localizedDescription)
        }
        
    }
    
    func playMusic() {
        let url = Bundle.main.url(forResource: "music", withExtension: "wav")!
        do {
            musicPlayer = try AVAudioPlayer(contentsOf: url)
            guard let musicPlayer = musicPlayer else { return }
            
            musicPlayer.prepareToPlay()
            musicPlayer.play()
        } catch let error {
            print(error.localizedDescription)
        }
     musicPlayer?.numberOfLoops = -1
    }

}
