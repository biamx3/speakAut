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
        // place the camera

        self.scene = getScene()
        // Do any additional setup after loading the view, typically from a nib.
        self.sceneView = SCNView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        self.sceneView.scene = self.scene
        self.sceneView.delegate = self
        self.view.addSubview(self.sceneView)
        
        // create and add a camera to the scene
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 2, z: 3)
        scene.rootNode.addChildNode(cameraNode)
        
    }
    
//    let characterViewModel = CharacterViewModel(characterModel: characterArray[i])
//    let characterNode = characterViewModel.sceneArray[0].rootNode
//    characterNode.name = characterViewModel.characterModel.name
//    characterNode.scale = SCNVector3(characterNode.scale.x*2, characterNode.scale.y*2, characterNode.scale.z*2)
    
    
    
    func getScene() -> SCNScene {
        self.chosenCharacter = DAO.sharedInstance.chosenCharacter
        
        let characterViewModel = CharacterViewModel(characterModel: chosenCharacter.characterModel)
//
//        for i in 0...chosenCharacterSentenceArray.count - 1 {
//            if chosenCharacterSentenceArray[i].index == chosenSentence?.index {
//                index = i
//            }
//        }
//
//
        let animationSceneIndex = DAO.sharedInstance.chosenSentence.index
        print("animation scene index", animationSceneIndex)
        
        let characterNode = characterViewModel.sceneArray[animationSceneIndex].rootNode
 
        
//        for i in 0 ... self.chosenCharacter.characterModel.sentenceArray.count - 1 {
//            if self.chosenCharacter.characterModel.sentenceArray[i].animationSceneName == animationSceneName {
//
//            //characterNode = self.chosenCharacter.characterModel.sentenceArray[i].rootNode
//            }
        
            //let characterNode = characterViewModel.sceneArray[0].rootNode
            //if scene.rootNode.
  //      }
//        let animationScene = SCNScene(named: animationSceneName , inDirectory: "art.scnassets", options: nil)
    
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
}
