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
import SpriteKit

class ViewController: UIViewController {
    
    var sceneView: SCNScene!
    var animations = [String: CAAnimation]()
    var idle:Bool = true
    var character:SCNNode!
    var headMesh:SCNNode!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dao = DAO()
        //dao.getCharacter()

        
        // create a new scene
        let scene = SCNScene(named: "art.scnassets/character.dae")!
       // let scene = SCNScene()
        
        sceneView = scene
        character = scene.rootNode
        //headMesh = character.childNode(withName: "headMesh", recursively: true)
       // headMesh?.geometry!.firstMaterial!.diffuse.contents = SKTexture(imageNamed: "texture")
        //let material = result.node.geometry!.firstMaterial!
        
        // create and add a camera to the scene
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        
        // place the camera
        //default:  cameraNode.position = SCNVector3(x: 0, y: 5, z: 15)
        cameraNode.position = SCNVector3(x: 0, y: 5, z: 30)
        
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
        scnView.backgroundColor = UIColor.white
        
        // Load the DAE animations
        loadAnimations()
        
        animations.first?.value.usesSceneTimeBase = true
        
        printAllNodes(tab: "", node: character)

        // add a tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        scnView.addGestureRecognizer(tapGesture)
        
        
        addHair(named: "art.scnassets/hair_z_head_zeroed3.dae")
    }
    
    
    //How to export a hair mesh from Maya to Xcode:
    /*
     First position hair on top of a rigged T-Stance character. Then, edit pivot. Turn on snap to point tool and snap pivot to the mixamorig_Head bone. Rotate y axis to point at mixamorig_HeadTop_End. Delete rigged T-Stance character, leaving only hair. Turn off snap to point tool and turn on snap to grid. Move hair until pivot is on 0,0,0. Delete history and freeze transformations. Export as DAE with Axis conversion to Z. Import to Xcode. Change Local Euler X rotation coordinates from 90 to 0.
    */
    
    //Hair naming convention:
    /*
     The .dae file should always be started with "hair_", followed by length ("cropped", "short", "medium", "long") and then a quirky adjective or name (for example, "boyish", "pigtail", "mohawk"). The name of the mesh should always be "hair".
     */
    
    func addHair(named hairSceneName: String) {
        
        if let scene = SCNScene(named: hairSceneName) {
            
            if let hair = scene.rootNode.childNode(withName: "hair", recursively: true) {
                if let headRef = character.childNode(withName: "mixamorig_Head", recursively: true) {
                    print("Adicionando em ", headRef.name)
                    headRef.addChildNode(hair)
                }

            }
        }
    }
    
    
    func printAllNodes(tab:String, node:SCNNode) {
        let aTab = tab + "  "
        for child in node.childNodes {
            print(aTab, child.name ?? "--- sem nome ---")
            printAllNodes(tab: aTab, node: child)
            
        }
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
            material.diffuse.contents = SKTexture(imageNamed: "BodyTexture.png")
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
        
        // This node will be parent of all the animation models
        let node = SCNNode()
        
        
        
        // Add all the child nodes to the parent node
        for child in character.childNodes {
            node.addChildNode(child)
        }
        
        // Set up some properties
        node.position = SCNVector3(0, -1, -2)
        node.scale = SCNVector3(0.2, 0.2, 0.2)
        
        
        // Add the node to the scene
        
        sceneView.rootNode.addChildNode(node)
        
      //  addHair(named: "art.scnassets/hair3.dae")
        
        // Load all the DAE animations
        loadAnimation(withKey: "dancing", sceneName: "art.scnassets/character", animationIdentifier: "character-1")
        
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
