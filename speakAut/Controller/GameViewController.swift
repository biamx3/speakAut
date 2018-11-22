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
class GameViewController: UIViewController, GameSceneDelegate {
        
        private var confettiView: SAConfettiView!

        override func loadView() {
            self.view = SKView()
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            if let view = self.view as! SKView? {
                // Load the SKScene from 'GameScene.sks'
                if let scene = GameScene(fileNamed: "GameScene") {
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .resizeFill
                    
                    // Present the scene
                    view.presentScene(scene)
                    
                    scene.gameSceneDelegate = self
                    
                    
                    //Why is size 0 in the beginning?
                    print("size : ", self.view.bounds)
                    print("scene size: ", scene.size)
                }
                
                view.ignoresSiblingOrder = true
                
                view.showsFPS = false
                view.showsNodeCount = true
            }
            
            confettiView = SAConfettiView(frame: CGRect(x: 0, y: 0, width: 1000, height: 0))
            confettiView.type = .Star
            confettiView.intensity = 0.9
            view.addSubview(confettiView)
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
        
        func turnOnConfetti(){
            print("turn on confetti")
            confettiView.startConfetti()
        }
        
        func turnOffConfetti() {
            confettiView.stopConfetti()
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Release any cached data, images, etc that aren't in use.
        }
        
        override var prefersStatusBarHidden: Bool {
            return true
        }
    }


