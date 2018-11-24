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

    
    override init() {
        super.init()
    }
    
    init(characterModel: Character) {
        super.init()
        self.characterModel = characterModel
        
        for i in 0...self.characterModel.sentenceArray.count - 1 {
            if let scene = SCNScene(named: "art.scnassets/\(characterModel.sentenceArray[i].animationSceneName).dae") {
                self.sceneArray.append(scene)
            }
        }

        self.defineTexture()
        self.addHair()

        if characterModel.hasEars {
            self.addEars()
        }

        if characterModel.hasGlasses {
            self.addGlasses()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func defineTexture(){
        for i in 0 ... self.sceneArray.count - 1 {
            let characterName = self.characterModel.name
            let headMesh = self.sceneArray[i].rootNode.childNode(withName: "head", recursively: true)
            headMesh?.geometry!.firstMaterial!.diffuse.contents = SKTexture(imageNamed: "art.scnassets/headTexture_\(characterName)")
            let bodyMesh = self.sceneArray[i].rootNode.childNode(withName: "body", recursively: true)
            bodyMesh?.geometry!.firstMaterial!.diffuse.contents = SKTexture(imageNamed: "art.scnassets/bodyTexture_\(characterName)")
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
        if let scene = SCNScene(named: "art.scnassets/ears.dae") {
            if let ears = scene.rootNode.childNode(withName: "ears", recursively: true) {
                for i in 0 ... self.sceneArray.count - 1 {
                    if let headRef = sceneArray[i].rootNode.childNode(withName: "mixamorig_Head", recursively: true) {
                        headRef.addChildNode(ears)
                    }
                }
            }
        }
    }
    
    func addGlasses() {
        if let scene = SCNScene(named: "art.scnassets/glasses.dae") {
            if let glasses = scene.rootNode.childNode(withName: "glasses", recursively: true) {
                for i in 0 ... self.sceneArray.count - 1 {
                    if let headRef = sceneArray[i].rootNode.childNode(withName: "mixamorig_Head", recursively: true) {
                        print("Adicionando em ", headRef.name ?? "")
                        headRef.addChildNode(glasses)
                    }
                }
            }
        }
    }
    
}
