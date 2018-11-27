//
//  SelectionViewController.swift
//  speakAut
//
//  Created by Beatriz Melo Mousinho Magalhães on 16/11/18.
//  Copyright © 2018 Beatriz Melo Mousinho Magalhães. All rights reserved.
//

import UIKit
import SceneKit
import SpriteKit

class SelectionViewController: UIViewController, SCNSceneRendererDelegate, UICharSelectionDelegate {

    var sceneView: SCNView!
    var spriteScene: UICharSelection!
    private var scene = CarousselCharSelection()
    var chosenCharacter: Character!
    var animations = [String: CAAnimation]()
    var idle:Bool = true
    var character: SCNNode!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationController?.delegate = self as! UINavigationControllerDelegate
        
        self.sceneView = SCNView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        self.sceneView.scene = scene
        self.sceneView.delegate = self
        
        
        self.spriteScene = UICharSelection(size: self.view.bounds.size)
        spriteScene.uiCharSelectionDelegate = self
        self.sceneView.overlaySKScene = self.spriteScene
        
        self.view.addSubview(self.sceneView)

    }
    
    func previousCharacter() {
        self.scene.previousPosition()
    }
    
    func nextCharacter() {
        self.scene.nextPosition()
        stopAnimation(key: "dancing")
    }
    
    func selectCharacter() {
        for character in DAO.sharedInstance.characterArray {
            if character.name == self.scene.centralCharacter.name {
                self.chosenCharacter = character
                DAO.sharedInstance.chosenCharacter = CharacterViewModel(characterModel: chosenCharacter)
            }
        }
        
        let gameViewController = GameViewController()
        gameViewController.chosenCharacter = self.chosenCharacter
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        present(gameViewController, animated: false, completion: nil)
        if self.isBeingPresented {
            self.dismiss(animated: false, completion: {})
        }
    }
    
    func goToMenuScreen() {
        print("go to menu screen")
    }
    
    func printAllNodes(tab:String, node:SKNode) {
        let aTab = tab + "  "
        for child in node.children {
            print(aTab, child.name ?? "--- sem nome ---")
            printAllNodes(tab: aTab, node: child)
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadAnimations () {
        // Load the character in the idle animation
        
        // This node will be parent of all the animation models
        let node = SCNNode()

        // Add all the child nodes to the parent node
        for child in self.scene.totalCharacters {
            node.addChildNode(child)
        }
        
        // Set up some properties
        node.position = SCNVector3(0, -1, -2)
        node.scale = SCNVector3(0.2, 0.2, 0.2)
        
        // Add the node to the scene
        
        self.scene.rootNode.addChildNode(node)
        
        // Load all the DAE animations
      //  loadAnimation(withKey: "dancing", sceneName: "art.scnassets/idle_luciana", animationIdentifier: "idle_luciana-1")
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
        self.scene.rootNode.addAnimation(animations[key]!, forKey: key)
    }
    
    func stopAnimation(key: String) {
        // Stop the animation with a smooth transition
//        self.scene.leftCharacter.removeAllAnimations()
//        self.scene.rootNode.removeAnimation(forKey: key, blendOutDuration: CGFloat(0.5))
    }
}
