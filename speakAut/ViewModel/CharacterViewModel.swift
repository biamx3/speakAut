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
    
    weak var characterModel: Character!
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
            self.defineEarTexture()
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
            let characterNode = self.sceneArray[i].rootNode
            characterNode.setStaticTextures(nodeName: "body", characterName: characterName)
        }
    }
    
    func defineEarTexture(){
        for i in 0 ... self.sceneArray.count - 1 {
            print("name: ", self.characterModel.name)
            let earMesh = self.sceneArray[i].rootNode.childNode(withName: "ear", recursively: true)
            earMesh?.geometry!.firstMaterial!.diffuse.contents = SKTexture(imageNamed: "art.scnassets/earTexture_\(self.characterModel.name)")
            earMesh?.geometry!.firstMaterial!.multiply.contents = SKTexture(imageNamed: "art.scnassets/earTexture_\(self.characterModel.name)")
            earMesh?.geometry!.firstMaterial!.multiply.intensity = 1.0
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
            if let scene = SCNScene(named: "art.scnassets/ear.dae") {
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
