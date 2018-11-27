//
//  GameViewController.swift
//  speakAut
//
//  Created by Beatriz Melo Mousinho Magalhães on 15/10/18.
//  Copyright © 2018 Beatriz Melo Mousinho Magalhães. All rights reserved.
//

    import UIKit
    import SpriteKit
    import SceneKit
    
    @objc(GameViewController)
class GameViewController: UIViewController, GameSceneDelegate {
   
        
        var skView: SKView!
        
        var chosenCharacter: Character!
        var cardType: CardType! = .GameScene
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            //Start with GameScene Instructions!
                    // Load the SKScene from 'GameScene.sks'
                    if let scene = GameScene(fileNamed: "GameScene") {
                        // Set the scale mode to scale to fit the window
                        scene.scaleMode = .resizeFill
                        scene.gameSceneDelegate = self
                        scene.chosenCharacter = self.chosenCharacter
                        self.skView = SKView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
                        
                        // Present the scene
                        skView!.presentScene(scene)

                    }
                    
                    skView!.ignoresSiblingOrder = false
                    skView!.showsFPS = false
                    skView!.showsNodeCount = false
                    
                    self.view.addSubview(skView!)
        }
        
        
        
        func goToCharacterSelectionScreen() {
                self.performSegue(withIdentifier: "gameToSelection", sender: nil)
        }
        
        func goToRepeatWordsScene() {
            self.performSegue(withIdentifier: "gameToRepeat", sender: nil)
        }
        
        override var shouldAutorotate: Bool {
            return true
        }
        
        override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
            if UIDevice.current.userInterfaceIdiom == .phone {
                return .landscape
            } else {
                return .landscape
            }
        }

        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Release any cached data, images, etc that aren't in use.
        }
        
        override var prefersStatusBarHidden: Bool {
            return true
        }
    }


