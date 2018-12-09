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
        
        
        override func viewWillAppear(_ animated: Bool) {
            self.navigationController?.popToViewController(self, animated: true)
            //Start with GameScene Instructions!
            if let scene = GameScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .resizeFill
                scene.gameSceneDelegate = self
                scene.chosenCharacter = DAO.sharedInstance.chosenCharacter.characterModel
                self.skView = SKView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
                // Present the scene
                skView!.presentScene(scene)
            }
            
            skView!.ignoresSiblingOrder = false
            skView!.showsFPS = false
            skView!.showsNodeCount = false
            let backgroundImage = UIImageView(image: UIImage(named: "backgroundImage"))
            self.view.addSubview(backgroundImage)
            self.view.addSubview(skView!)
            SoundTrack.sharedInstance.playMusic(withName: "gameplaySong")
        }
        
    
        func goToCharacterSelectionScreen() {
            DispatchQueue.main.async {
                self.navigationController?.popToViewController(ofClass: SelectionViewController.self)
            }

        }
        
        func goToRepeatWordsScene() {
            let repeatViewController = RepeatViewController()
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(repeatViewController, animated: true)
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
        
        override func viewWillDisappear(_ animated: Bool) {
            self.skView = nil
        }

        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Release any cached data, images, etc that aren't in use.
        }
        
        override var prefersStatusBarHidden: Bool {
            return true
        }
    
    }


