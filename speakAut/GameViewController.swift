//
//  GameViewController.swift
//  speakAut
//
//  Created by Beatriz Melo Mousinho Magalhães on 31/08/18.
//  Copyright © 2018 Beatriz Melo Mousinho Magalhães. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class GameViewController: UIViewController {
    
    var sceneView: SCNScene!
    var animations = [String: CAAnimation]()
    var idle:Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create a new scene
        let scene = SCNScene(named: "art.scnassets/character_1.dae")!
       // let scene = SCNScene()
        
        sceneView = scene
        
        
        // create and add a camera to the scene
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        
        // place the camera
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 5)
        
        // create and add a light to the scene
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = .omni
        lightNode.position = SCNVector3(x: 0, y: 10, z: 5)
        scene.rootNode.addChildNode(lightNode)
        
        // create and add an ambient light to the scene
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = .ambient
        ambientLightNode.light!.color = UIColor.darkGray
        scene.rootNode.addChildNode(ambientLightNode)
        
       // retrieve the SCNView
        let scnView = self.view as! SCNView
        
        // set the scene to the view
        scnView.scene = scene
        
        // allows the user to manipulate the camera
        scnView.allowsCameraControl = true
        
        // show statistics such as fps and timing information
        scnView.showsStatistics = true
        
        // configure the view
        scnView.backgroundColor = UIColor.black
        
        // Load the DAE animations
        loadAnimations()
        

//        // add a tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        scnView.addGestureRecognizer(tapGesture)
    }
    
    @objc
    func handleTap(_ gestureRecognize: UIGestureRecognizer) {
        // retrieve the SCNView
        let scnView = self.view as! SCNView

        // check what nodes are tapped
        let p = gestureRecognize.location(in: scnView)
        let hitResults = scnView.hitTest(p, options: [:])
        // check that we clicked on at least one object
        if hitResults.count > 0 {
            // retrieved the first clicked object
            let result = hitResults[0]

            // get its material
            let material = result.node.geometry!.firstMaterial!

            // highlight it
            SCNTransaction.begin()
            material.diffuse.contents = UIImage(named: "BodyTexture")
            SCNTransaction.animationDuration = 0.5

            // on completion - unhighlight
            SCNTransaction.completionBlock = {
                SCNTransaction.begin()
                SCNTransaction.animationDuration = 0.5


                material.emission.contents = UIColor.black

                SCNTransaction.commit()
            }

            material.emission.contents = UIColor.red

            SCNTransaction.commit()
        }
    }
    
    func loadAnimations () {
        // Load the character in the idle animation
        let idleScene = SCNScene(named: "art.scnassets/character_1.dae")!
        
        // This node will be parent of all the animation models
        let node = SCNNode()
        
        
        
        // Add all the child nodes to the parent node
        for child in idleScene.rootNode.childNodes {
            node.addChildNode(child)
        }
        
        // Set up some properties
        node.position = SCNVector3(0, -1, -2)
        node.scale = SCNVector3(0.2, 0.2, 0.2)
        
        
        // Add the node to the scene
        
        sceneView.rootNode.addChildNode(node)
        
        // Load all the DAE animations
        loadAnimation(withKey: "dancing", sceneName: "art.scnassets/character_2", animationIdentifier: "character_2-1")
        
        let character_2 = sceneView.rootNode.childNode(withName: "character_2", recursively: true)
        character_2?.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "FaceTexture.png")
        
        let character_1 = sceneView.rootNode.childNode(withName: "character_1", recursively: true)
        character_1?.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "FaceTexture.png")
        
    }
    
    func loadAnimation(withKey: String, sceneName:String, animationIdentifier:String) {
        let sceneURL = Bundle.main.url(forResource: sceneName, withExtension: "dae")
        let sceneSource = SCNSceneSource(url: sceneURL!, options: nil)
        
        if let animationObject = sceneSource?.entryWithIdentifier(animationIdentifier, withClass: CAAnimation.self) {
            // The animation will only play once
            animationObject.repeatCount = 1
            // To create smooth transitions between animations
            animationObject.fadeInDuration = CGFloat(1)
            animationObject.fadeOutDuration = CGFloat(0.5)
            
            // Store the animation for later use
            animations[withKey] = animationObject
        }
    }
    
    
    func playAnimation(key: String) {
        // Add the animation to start playing it right away
        sceneView.rootNode.addAnimation(animations[key]!, forKey: key)
    }
    
    func stopAnimation(key: String) {
        // Stop the animation with a smooth transition
        sceneView.rootNode.removeAnimation(forKey: key, blendOutDuration: CGFloat(0.5))
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
