//
//  CarousselCharSelection.swift
//  speakAut
//
//  Created by Beatriz Melo Mousinho Magalhães on 14/11/18.
//  Copyright © 2018 Beatriz Melo Mousinho Magalhães. All rights reserved.
//

import UIKit
import SceneKit

class CarousselCharSelection: SCNScene {
    
    private var cube: SCNBox!
    private var cubeNode: SCNNode!
    private var cameraNode: SCNNode!
    private var lightNode: SCNNode!
    private var character:SCNNode!
    private var headMesh:SCNNode!
    
    private var customRootNode: SCNNode!
    
    
    override init() {
        super.init()
        
        let cube = SCNBox(width: 3, height: 3, length: 3, chamferRadius: 0)
        let cubeMaterial = SCNMaterial()
        cubeMaterial.diffuse.contents = UIColor.blue
        cube.materials = [cubeMaterial]
        self.cubeNode = SCNNode(geometry: cube)
        self.cubeNode.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 0.01, z: 0, duration: 1.0/60.0)))
   
        let camera = SCNCamera()
        camera.xFov = 60
        camera.yFov = 60
        
        let ambientLight = SCNLight()
        ambientLight.type = SCNLight.LightType.ambient
        ambientLight.color = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        
        let cameraConstraint = SCNLookAtConstraint(target: self.cubeNode)
        cameraConstraint.isGimbalLockEnabled = true
        
        self.cameraNode = SCNNode()
        self.cameraNode.camera = camera
        self.cameraNode.constraints = [cameraConstraint]
        self.cameraNode.light = ambientLight
        self.cameraNode.position = SCNVector3(x: 5, y: 5, z: 5)
        self.cameraNode.name = "cameraNod"
        
        let omniLight = SCNLight()
        omniLight.type = SCNLight.LightType.omni
        
        self.lightNode = SCNNode()
        self.lightNode.light = omniLight
        self.lightNode.position = SCNVector3(x: -3, y: 5, z: 3)
        self.lightNode.name = "lightnode"
        

        self.rootNode.addChildNode(self.cameraNode)
        self.rootNode.addChildNode(self.lightNode)
        
        
       let brothers = self.rootNode.allDescendants()
        print("brothers ", brothers, "end of brothers")
        
        let cube2 = SCNBox(width: 1, height: 1, length: 1, chamferRadius: 0)
        let cubeMaterial2 = SCNMaterial()
        cubeMaterial2.diffuse.contents = UIColor.red
        cube2.materials = [cubeMaterial2]
        self.customRootNode = SCNNode(geometry: cube2)
        self.rootNode.addChildNode(customRootNode)
        
    }
    
    func turnRed() {
        print("turn red")
        self.customRootNode.addChildNode(self.cubeNode)
    }
    
    
    func printAllNodes(tab:String, node:SCNNode) {
        let aTab = tab + "  "
        for child in node.childNodes {
            print(aTab, child.name ?? "--- sem nome ---")
            printAllNodes(tab: aTab, node: child)
            
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
