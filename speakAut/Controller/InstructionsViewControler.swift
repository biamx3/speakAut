//
//  InstructionsViewControler.swift
//  speakAut
//
//  Created by Beatriz Melo Mousinho Magalhães on 22/11/18.
//  Copyright © 2018 Beatriz Melo Mousinho Magalhães. All rights reserved.
//

import UIKit
import SpriteKit

class InstructionsViewControler: UIViewController {
    
    var sceneView: SKView?
    
    private var scene = SKScene()
    
    var instructionsType: VCType!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //First time loading View Controller
        instructionsType = .Game
        
        //Instructions for GameScene
        if instructionsType == .Game {
            if let view = self.sceneView {
                if let scene = SKScene(fileNamed: "GameSceneInstructions") {
                    scene.scaleMode = .resizeFill
                    view.presentScene(scene)
                }
            }
            
        //Instructions for RepeatWordsScene
        } else if instructionsType == .RepeatWords {
            if let view = self.sceneView {
                if let scene = SKScene(fileNamed: "RepeatWordsInstructions") {
                    scene.scaleMode = .resizeFill
                    view.presentScene(scene)
                }
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
