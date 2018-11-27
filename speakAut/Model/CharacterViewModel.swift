//
//  CharacterViewModel.swift
//  speakAut
//
//  Created by Beatriz Melo Mousinho Magalhães on 24/11/18.
//  Copyright © 2018 Beatriz Melo Mousinho Magalhães. All rights reserved.
//

import UIKit
import SceneKit
import SpriteKit

class CharacterViewModel: SCNNode {
    
    var characterModel: Character!
    var sceneArray: [SCNScene] = []
    var nodeArray: [SCNNode] = []
    var idlePlayer = SCNAnimationPlayer()

    
    override init() {
        super.init()
    }
    
    init(characterModel: Character) {
        super.init()
        self.characterModel = characterModel
        
        self.sceneArray = []
        self.nodeArray = []
        
        for i in 0...self.characterModel.sentenceArray.count - 1 {
            if let scene = SCNScene(named: characterModel.sentenceArray[i].animationSceneName, inDirectory: "art.scnassets", options: nil ) {
                let characterNode = scene.rootNode
                self.nodeArray.append(characterNode)
                self.sceneArray.append(scene)
            }
        }
        
        self.addHair()

        if self.characterModel.hasEars  {
            self.addEars()
        }
        
        if self.characterModel.hasGlasses {
            self.addGlasses()
        }


        
        self.defineTexture()
        self.setScale()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func defineTexture(){
        for i in 0 ... self.sceneArray.count - 1 {
            let characterName = self.characterModel.name
            let headMesh = self.sceneArray[i].rootNode.childNode(withName: "head", recursively: true)
            
            //Add texture to head
            headMesh?.geometry!.firstMaterial!.multiply.contents = SKTexture(imageNamed: "art.scnassets/headTexture_\(characterName)")
            headMesh?.geometry!.firstMaterial!.multiply.intensity = 0.7
            headMesh?.geometry!.firstMaterial!.diffuse.contents = SKTexture(imageNamed: "art.scnassets/headTexture_\(characterName)")
            
            //Add texture to body
            let bodyMesh = self.sceneArray[i].rootNode.childNode(withName: "body", recursively: true)
            bodyMesh?.geometry!.firstMaterial!.diffuse.contents = SKTexture(imageNamed: "art.scnassets/bodyTexture_\(characterName)")
            bodyMesh?.geometry!.firstMaterial!.multiply.contents = SKTexture(imageNamed: "art.scnassets/bodyTexture_\(characterName)")
            bodyMesh?.geometry!.firstMaterial!.multiply.intensity = 0.7
            
            //Add texture to ears
            let earMeshRight = self.sceneArray[i].rootNode.childNode(withName: "ears_r", recursively: true)
            earMeshRight?.geometry!.firstMaterial!.diffuse.contents = SKTexture(imageNamed: "art.scnassets/earTexture_\(characterName)")
            let earMeshLeft = self.sceneArray[i].rootNode.childNode(withName: "ears_l", recursively: true)
            earMeshLeft?.geometry!.firstMaterial!.diffuse.contents = SKTexture(imageNamed: "art.scnassets/earTexture_\(characterName)")
            earMeshRight?.geometry!.firstMaterial!.diffuse.contents = SKTexture(imageNamed: "art.scnassets/earTexture_\(characterName)")
            earMeshRight?.geometry!.firstMaterial!.multiply.contents = SKTexture(imageNamed: "art.scnassets/earTexture_\(characterName)")
            earMeshRight?.geometry!.firstMaterial!.multiply.intensity = 0.7
            earMeshLeft?.geometry!.firstMaterial!.multiply.contents = SKTexture(imageNamed: "art.scnassets/earTexture_\(characterName)")
            earMeshLeft?.geometry!.firstMaterial!.multiply.intensity = 0.7
        }
    }
    
    func addHair() {
        for i in 0 ... self.sceneArray.count - 1 {
            let characterName = self.characterModel.name
            if let scene = SCNScene(named: "art.scnassets/hair_\(characterName).dae") {
                if let hair = scene.rootNode.childNode(withName: "hair", recursively: true) {
                    if let headRef = sceneArray[i].rootNode.childNode(withName: "mixamorig_Head", recursively: true) {
                        headRef.addChildNode(hair)
                    }
                }
            }
        }
    }

    func addEars() {
        for i in 0 ... self.sceneArray.count - 1 {
            if let scene = SCNScene(named: "art.scnassets/ears.dae") {
                if let ears = scene.rootNode.childNode(withName: "ears", recursively: true) {
                    if let headRef = sceneArray[i].rootNode.childNode(withName: "mixamorig_Head", recursively: true) {
                        headRef.addChildNode(ears)
                    }
                }
            }
        }
    }
    
    func addGlasses() {
        for i in 0 ... self.sceneArray.count - 1 {
            if let scene = SCNScene(named: "art.scnassets/glasses.dae") {
                if let glasses = scene.rootNode.childNode(withName: "glassesMesh", recursively: true) {
                    if let headRef = sceneArray[i].rootNode.childNode(withName: "mixamorig_Head", recursively: true) {
                        print("Adicionando em ", headRef.name ?? "")
                        headRef.addChildNode(glasses)
                    }
                }
            }
        }
    }
    
    func setScale() {
        for i in 0 ... self.sceneArray.count - 1 {
            if let scene = SCNScene(named: self.characterModel.sentenceArray[i].animationSceneName, inDirectory: "art.scnassets", options: nil ) {
                if let characterNode = scene.rootNode.childNode(withName: "character", recursively: true) {
                    characterNode.scale = SCNVector3(characterNode.scale.x*2, characterNode.scale.y*2, characterNode.scale.z*2)
                }
            }
        }
    }
    
}
