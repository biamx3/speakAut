//
//  FinalViewController.swift
//  speakAut
//
//  Created by Beatriz Melo Mousinho Magalhães on 27/11/18.
//  Copyright © 2018 Beatriz Melo Mousinho Magalhães. All rights reserved.
import UIKit
import QuartzCore
import SceneKit
import SpriteKit

class FinalViewController: UIViewController {
    
    var sceneView: SCNView!
    var spriteScene: UICharSelection!
    private var scene: SCNScene!
    var chosenCharacter: CharacterViewModel!
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.scene = getScene()
        self.sceneView = SCNView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        self.sceneView.scene = self.scene
        self.view.addSubview(self.sceneView)
        animateCamera()
    }
    
    func animateCamera(){
        let camera = self.sceneView.scene?.rootNode.childNode(withName: "camera", recursively: true)
        camera?.position = SCNVector3(-5, 1, 8)
        let moveCamera = SCNAction.move(to: SCNVector3(1, 0.5, 5), duration: 6.0)
        let wait = SCNAction.wait(duration: 3.0)
        moveCamera.timingMode = .easeOut
        let sequence = SCNAction.sequence([moveCamera, wait])
        camera?.runAction(sequence, completionHandler: {
            DispatchQueue.main.async {
                self.navigationController?.popToViewController(ofClass: GameViewController.self)
            }
            })
        camera?.runAction(moveCamera)
    }
    
    func getScene() -> SCNScene {
        self.chosenCharacter = DAO.sharedInstance.chosenCharacter
        let characterViewModel = CharacterViewModel(characterModel: chosenCharacter.characterModel)
        let animationSceneIndex = DAO.sharedInstance.chosenSentence.index
        let characterNode = characterViewModel.sceneArray[animationSceneIndex].rootNode
        characterNode.animateTextures(nodeName: "head", animation: DAO.sharedInstance.chosenSentence.headTexture)
        let animationScene = SCNScene(named: "SuccessAnimationScene.scn", inDirectory: "art.scnassets", options: nil)
        animationScene?.rootNode.addChildNode(characterNode)
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
    
    override func viewWillDisappear(_ animated: Bool) {
        self.sceneView = nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.sceneView = nil
    }
    
}

extension UINavigationController {
    
    func popToViewController(ofClass: AnyClass, animated: Bool = true) {
        if let vc = viewControllers.filter({$0.isKind(of: ofClass)}).last {
            popToViewController(vc, animated: animated)
        }
    }
    
    func popViewControllers(viewsToPop: Int, animated: Bool = true) {
        if viewControllers.count > viewsToPop {
            let vc = viewControllers[viewControllers.count - viewsToPop - 1]
            popToViewController(vc, animated: animated)
        }
    }
    
}
