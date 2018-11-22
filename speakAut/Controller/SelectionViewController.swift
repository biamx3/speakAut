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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.sceneView = SCNView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        self.sceneView.scene = scene
        self.sceneView.delegate = self
        
        
        self.spriteScene = UICharSelection(size: self.view.bounds.size)
        spriteScene.uiCharSelectionDelegate = self
        self.sceneView.overlaySKScene = self.spriteScene
        
        self.view.addSubview(self.sceneView)
        
        printAllNodes(tab: "", node: self.spriteScene)
        
    }
    
    func previousCharacter() {
        self.scene.previousPosition()
    }
    
    func nextCharacter() {
        self.scene.nextPosition()
    }
    
    func selectCharacter() {
        print("character was selected")
        let gameViewController = GameViewController()
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

}
