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

class SuccessAnimationViewController: UIViewController, SCNSceneRendererDelegate, UIViewControllerTransitioningDelegate {
    
    var sceneView: SCNView!
    var spriteScene: UICharSelection!
    private var scene: SCNScene!
    var chosenCharacter: CharacterViewModel!
    var animations = [String: CAAnimation]()
    var idle:Bool = true
    var character: SCNNode!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // place the camera

        self.scene = getScene()
        // Do any additional setup after loading the view, typically from a nib.
        self.sceneView = SCNView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        self.sceneView.scene = self.scene
        self.sceneView.delegate = self
        self.view.addSubview(self.sceneView)
        
        let camera = self.sceneView.scene?.rootNode.childNode(withName: "camera", recursively: true)
        camera?.position = SCNVector3(-5, 1, 8)
        let moveCamera = SCNAction.move(to: SCNVector3(1, 0.5, 5), duration: 6.0)
        moveCamera.timingMode = .easeOut
        let wait = SCNAction.wait(duration: 3.0)
        let sequence = SCNAction.sequence([moveCamera, wait])
        camera?.runAction(sequence, completionHandler: {
            print("nextScreen")
            self.goBackToGameScene()
            })

    }
    
    
    
    func getScene() -> SCNScene {
        self.chosenCharacter = DAO.sharedInstance.chosenCharacter
        
        let characterViewModel = CharacterViewModel(characterModel: chosenCharacter.characterModel)

        let animationSceneIndex = DAO.sharedInstance.chosenSentence.index
        print("animation scene index", animationSceneIndex)
        
        let characterNode = characterViewModel.sceneArray[animationSceneIndex].rootNode
    
        let animationScene = SCNScene(named: "SuccessAnimationScene.scn", inDirectory: "art.scnassets", options: nil)
        
        animationScene?.rootNode.addChildNode(characterNode)
    
        return animationScene ?? SCNScene(named: "idle_luciana" , inDirectory: "art.scnassets", options: nil)!
    }
    

    func goBackToGameScene() {
        let gameViewController = GameViewController()
        
        present(gameViewController, animated: true, completion: nil)
        if self.isBeingPresented {
            self.dismiss(animated: false, completion: {})
        }
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
