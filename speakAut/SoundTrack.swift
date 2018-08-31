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
var musicPlayer: AVAudioPlayer?

    func stopStound(){
        self.player?.stop()
    }
    
    func playSound(withName: String) {
    let url = Bundle.main.url(forResource: withName, withExtension: "mp3")!
    do {
        player = try AVAudioPlayer(contentsOf: url)
        guard let player = player else { return }
        
        player.prepareToPlay()
        player.play()
    } catch let error {
        print(error.localizedDescription)
    }
    
    }
    
    func playMusic() {
        let url = Bundle.main.url(forResource: "music", withExtension: "mp3")!
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
