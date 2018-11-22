//
//  GameViewController.swift
//  speakAut
//
//  Created by Beatriz Melo Mousinho Magalhães on 15/10/18.
//  Copyright © 2018 Beatriz Melo Mousinho Magalhães. All rights reserved.
//

    import UIKit
    import SpriteKit
    import SAConfettiView
    
    @objc(GameViewController)
class GameViewController: UIViewController, GameSceneDelegate  {

        override func loadView() {
            self.view = SKView()
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            //Start with GameScene Instructions!
                if let view = self.view as! SKView? {
                    // Load the SKScene from 'GameScene.sks'
                    if let scene = GameScene(fileNamed: "GameScene") {
                        // Set the scale mode to scale to fit the window
                        scene.scaleMode = .resizeFill
                        
                        // Present the scene
                        view.presentScene(scene)

                    }
                    
                    view.ignoresSiblingOrder = false
                    view.showsFPS = false
                    view.showsNodeCount = true
                }
        }
        
        func goToCharacterSelectionScreen() {
            let selectionViewController = SelectionViewController()
            present(selectionViewController, animated: true, completion: nil)
            if self.isBeingPresented {
                self.dismiss(animated: false, completion: {})
            }
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


