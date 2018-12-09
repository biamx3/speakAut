//
//  MenuViewController.swift
//  speakAut
//
//  Created by Beatriz Melo Mousinho Magalhães on 01/12/18.
//  Copyright © 2018 Beatriz Melo Mousinho Magalhães. All rights reserved.
//

import UIKit

import UIKit
import SpriteKit

class MenuViewController: UIViewController, MenuSceneDelegate {
    
    var skView: SKView!
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.popToViewController(self, animated: true)
        super.viewDidLoad()
        if let scene = MenuScene(fileNamed: "MenuScene") {
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .resizeFill
            scene.menuSceneDelegate = self
            self.skView = SKView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
            // Present the scene
            skView!.presentScene(scene)
            
        }
        let backgroundImage = UIImageView(image: UIImage(named: "backgroundImage"))
        self.view.addSubview(backgroundImage)
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
    
    func goToSelectionScreen() {
        DispatchQueue.main.async {
            let selectionViewController = SelectionViewController()
            self.navigationController?.pushViewController(selectionViewController, animated: true)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.skView = nil
        self.removeFromParent()
    }
    
}

