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
    
    private var cameraNode: SCNNode!
    private var lightNode: SCNNode!
    
    private var leftCharacter: SCNNode!
    private var centralCharacter: SCNNode!
    private var rightCharacter: SCNNode!
    
    private var visibleCharacters: [SCNNode]!
    private var totalCharacters = [SCNNode]()

    private var positionFarLeft: SCNVector3!
    private var positionLeft: SCNVector3!
    private var positionCenter: SCNVector3!
    private var positionRight: SCNVector3!
    private var positionFarRight: SCNVector3!
    
    override init() {
        super.init()
        setPositionValues()
        createCubes()
        addCamera()
        addLights()
        addFirstVisibleCharacters()
    }
    
    func setPositionValues(){
        self.positionFarLeft = SCNVector3(-8.0, -0.5, -6.0)
        self.positionLeft = SCNVector3(-4, 2.0, -4.0)
        self.positionCenter = SCNVector3(0.0, 2.0, 0.0)
        self.positionRight = SCNVector3(4, 2.0, -4.0)
        self.positionFarRight = SCNVector3(8.0, -0.5, -6.0)
    }
    
    func addCamera(){
        let camera = SCNCamera()
 
        self.cameraNode = SCNNode()
        self.cameraNode.camera = camera
        self.cameraNode.position = SCNVector3(x: 0, y: 2, z: 7)
        self.cameraNode.name = "cameraNod"

        self.rootNode.addChildNode(self.cameraNode)
    }
    
    func addFirstVisibleCharacters(){
        //Character in center position is the second one of the total characters array
        self.centralCharacter = self.totalCharacters[1]
        
        //Character in left position is previous index in array, idem for forward
        let centralCharIndex = totalCharacters.index(of: centralCharacter ?? totalCharacters[0])
        let nextIndex = (centralCharIndex ?? 0) + 1
        let previousIndex = (centralCharIndex ?? 0) - 1
        
        self.leftCharacter = totalCharacters[previousIndex]
        self.rightCharacter = totalCharacters[nextIndex]
        
        leftCharacter.position = positionLeft
        self.centralCharacter.position = positionCenter
        rightCharacter.position = positionRight
        
        leftCharacter.opacity = 0.7
        rightCharacter.opacity = 0.7

        
        self.rootNode.addChildNode(leftCharacter)
        self.rootNode.addChildNode(centralCharacter)
        self.rootNode.addChildNode(rightCharacter)
    }
    
    func previousPosition(){
        let centralCharIndex = totalCharacters.index(of: centralCharacter ?? totalCharacters[0])
        let moveToLeft = SCNAction.move(to: positionLeft, duration: 0.2)
        let moveToCenter = SCNAction.move(to: positionCenter, duration: 0.2)
        let moveToRight = SCNAction.move(to: positionRight, duration: 0.2)
        let moveToFarRight = SCNAction.move(to: positionFarRight, duration: 0.2)
        
        let lowerOpacity = SCNAction.fadeOpacity(to: 0.7, duration: 0.2)
        let heightenOpacity = SCNAction.fadeOpacity(to: 1.0, duration: 0.2)
        let fadeOut = SCNAction.fadeOut(duration: 0.2)
        
        let moveToRightLowerOpacity = SCNAction.group([moveToRight, lowerOpacity])
        let moveToLeftLowerOpacity = SCNAction.group([moveToLeft, lowerOpacity])
        
        let moveToCenterHeightenOpacity = SCNAction.group([moveToCenter, heightenOpacity])
        
        let moveToFarRightFadeOut = SCNAction.group([moveToFarRight, fadeOut])
        
        self.rightCharacter.runAction(moveToFarRightFadeOut)
        self.rightCharacter.removeFromParentNode()
        self.centralCharacter.runAction(moveToRightLowerOpacity)
        self.rightCharacter = centralCharacter
        self.leftCharacter.runAction(moveToCenterHeightenOpacity)
        self.centralCharacter = leftCharacter
        
        let leftCharIndex = totalCharacters.index(of: leftCharacter)
        
        var previousIndex = 0
        if leftCharIndex == 0 || centralCharIndex == 1 {
            previousIndex = totalCharacters.endIndex - 1
        } else {
            previousIndex = (leftCharIndex ?? 0) - 1
        }
        let newCharacter = totalCharacters[previousIndex]
        newCharacter.position = positionFarLeft
        self.rootNode.addChildNode(newCharacter)
        newCharacter.runAction(moveToLeftLowerOpacity)
        self.leftCharacter = newCharacter
    }
    
    func nextPosition(){
        let centralCharIndex = totalCharacters.index(of: centralCharacter ?? totalCharacters[0])
        let moveToFarLeft = SCNAction.move(to: positionFarLeft, duration: 0.2)
        let moveToLeft = SCNAction.move(to: positionLeft, duration: 0.2)
        let moveToCenter = SCNAction.move(to: positionCenter, duration: 0.2)
        let moveToRight = SCNAction.move(to: positionRight, duration: 0.2)
        
        let lowerOpacity = SCNAction.fadeOpacity(to: 0.7, duration: 0.2)
        let heightenOpacity = SCNAction.fadeOpacity(to: 1.0, duration: 0.2)
        let fadeOut = SCNAction.fadeOut(duration: 0.2)
        
        let moveToRightLowerOpacity = SCNAction.group([moveToRight, lowerOpacity])
        let moveToLeftLowerOpacity = SCNAction.group([moveToLeft, lowerOpacity])
        
        let moveToCenterHeightenOpacity = SCNAction.group([moveToCenter, heightenOpacity])
        
        let moveToFarLeftFadeOut = SCNAction.group([moveToFarLeft, fadeOut])
        
        self.leftCharacter.runAction(moveToFarLeftFadeOut)
        self.leftCharacter.removeFromParentNode()
        self.centralCharacter.runAction(moveToLeftLowerOpacity)
        self.leftCharacter = centralCharacter
        self.rightCharacter.runAction(moveToCenterHeightenOpacity)
        self.centralCharacter = rightCharacter
        
        let rightCharIndex = totalCharacters.index(of: rightCharacter)
        
        var nextIndex = 0
        if rightCharIndex == totalCharacters.endIndex || centralCharIndex == totalCharacters.endIndex - 2{
            nextIndex = 0
        } else {
            nextIndex = (rightCharIndex ?? 0) + 1
        }
        let newCharacter = totalCharacters[nextIndex]
        newCharacter.position = positionFarRight
        self.rootNode.addChildNode(newCharacter)
        newCharacter.runAction(moveToRightLowerOpacity)
        self.rightCharacter = newCharacter
    }

    func addLights(){
        let ambientLight = SCNLight()
        ambientLight.type = SCNLight.LightType.ambient
        ambientLight.color = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        
        self.cameraNode.light = ambientLight
        
        let omniLight = SCNLight()
        omniLight.type = SCNLight.LightType.omni
        
        self.lightNode = SCNNode()
        self.lightNode.light = omniLight
        self.lightNode.position = SCNVector3(x: -3, y: 5, z: 3)
        self.lightNode.name = "lightnode"
        
        self.rootNode.addChildNode(self.lightNode)
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
    
    func createCubes() {
        //Create all cubes; add them to "totalCharacters" array
        let cube1 = SCNBox(width: 2.68, height: 3.5, length: 2, chamferRadius: 0)
        let cubeMaterial1 = SCNMaterial()
        cubeMaterial1.diffuse.contents = UIColor.white
        cube1.materials = [cubeMaterial1]
        
        let cube2 = SCNBox(width: 2.68, height: 3.5, length: 2, chamferRadius: 0)
        let cubeMaterial2 = SCNMaterial()
        cubeMaterial2.diffuse.contents = UIColor.yellow
        cube2.materials = [cubeMaterial2]
        
        let cube3 = SCNBox(width: 2.68, height: 3.5, length: 2, chamferRadius: 0)
        let cubeMaterial3 = SCNMaterial()
        cubeMaterial3.diffuse.contents = UIColor.orange
        cube3.materials = [cubeMaterial3]
        
        let cube4 = SCNBox(width: 2.68, height: 3.5, length: 2, chamferRadius: 0)
        let cubeMaterial4 = SCNMaterial()
        cubeMaterial4.diffuse.contents = UIColor.red
        cube4.materials = [cubeMaterial4]
        
        let cube5 = SCNBox(width: 2.68, height: 3.5, length: 2, chamferRadius: 0)
        let cubeMaterial5 = SCNMaterial()
        cubeMaterial5.diffuse.contents = UIColor.purple
        cube5.materials = [cubeMaterial5]
        
        let cube6 = SCNBox(width: 2.68, height: 3.5, length: 2, chamferRadius: 0)
        let cubeMaterial6 = SCNMaterial()
        cubeMaterial6.diffuse.contents = UIColor.blue
        cube6.materials = [cubeMaterial6]
        
        var cubeNode1 = SCNNode()
        var cubeNode2 = SCNNode()
        var cubeNode3 = SCNNode()
        var cubeNode4 = SCNNode()
        var cubeNode5 = SCNNode()
        var cubeNode6 = SCNNode()
        
        cubeNode1 = SCNNode(geometry: cube1)
        cubeNode2 = SCNNode(geometry: cube2)
        cubeNode3 = SCNNode(geometry: cube3)
        cubeNode4 = SCNNode(geometry: cube4)
        cubeNode5 = SCNNode(geometry: cube5)
        cubeNode6 = SCNNode(geometry: cube6)
        
        cubeNode1.name = "cubeNode1"
        cubeNode2.name = "cubeNode2"
        cubeNode3.name = "cubeNode3"
        cubeNode4.name = "cubeNode4"
        cubeNode5.name = "cubeNode5"
        cubeNode6.name = "cubeNode6"

        
        cubeNode1.geometry?.firstMaterial?.diffuse.contents = UIColor.white
        cubeNode2.geometry?.firstMaterial?.diffuse.contents = UIColor.yellow
        cubeNode3.geometry?.firstMaterial?.diffuse.contents = UIColor.orange
        cubeNode4.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        cubeNode5.geometry?.firstMaterial?.diffuse.contents = UIColor.purple
        cubeNode6.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        
        self.totalCharacters.append(contentsOf: [cubeNode1,cubeNode2,cubeNode3, cubeNode4, cubeNode5, cubeNode6])
    }
}
