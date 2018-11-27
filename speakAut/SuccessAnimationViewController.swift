//
//  SuccessAnimationViewController.swift
//  speakAut
//
//  Created by Beatriz Melo Mousinho Magalhães on 27/11/18.
//  Copyright © 2018 Beatriz Melo Mousinho Magalhães. All rights reserved.

import UIKit
import QuartzCore
import SceneKit
import SpriteKit

class SuccessAnimationViewController: UIViewController, SCNSceneRendererDelegate {
    
    var sceneView: SCNView!
    var spriteScene: UICharSelection!
    private var scene: SCNScene!
    var chosenCharacter: CharacterViewModel!
    var animations = [String: CAAnimation]()
    var idle:Bool = true
    var character: SCNNode!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scene = getScene()
        // Do any additional setup after loading the view, typically from a nib.
        self.sceneView = SCNView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        self.sceneView.scene = self.scene
        self.sceneView.delegate = self
        self.view.addSubview(self.sceneView)
    }
    
    
    func getScene() -> SCNScene {
        self.chosenCharacter = DAO.sharedInstance.chosenCharacter
        let animationSceneName = DAO.sharedInstance.chosenSentence.animationSceneName
        let animationScene = SCNScene(named: animationSceneName , inDirectory: "art.scnassets", options: nil)
        return animationScene ?? SCNScene(named: "idle_luciana" , inDirectory: "art.scnassets", options: nil)!
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
}
