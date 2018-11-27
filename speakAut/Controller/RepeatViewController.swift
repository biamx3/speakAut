
////
////  RepeatViewController.swift
////  speakAut
////
////  Created by Beatriz Melo Mousinho Magalhães on 27/11/18.
////  Copyright © 2018 Beatriz Melo Mousinho Magalhães. All rights reserved.
////
//

import UIKit
import SpriteKit

class RepeatViewController: UIViewController, RepeatViewControllerDelegate {
    
    var skView: SKView!
    
        override func viewDidLoad() {
            super.viewDidLoad()
            //Start with GameScene Instructions!
            // Load the SKScene from 'GameScene.sks'
            if let scene = RepeatWordsScene(fileNamed: "RepeatWordsScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .resizeFill
                self.skView = SKView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
                scene.repeatViewControllerDelegate = self
                // Present the scene
                skView!.presentScene(scene)
    
            }
    
            skView!.ignoresSiblingOrder = false
            skView!.showsFPS = false
            skView!.showsNodeCount = false
    
            self.view.addSubview(skView!)
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
    
    func goToSuccessAnimationScreen() {
        self.performSegue(withIdentifier: "repeatToSuccess", sender: nil)
    }
    
}
