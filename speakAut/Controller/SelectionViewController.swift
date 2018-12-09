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

    private var sceneView: SCNView?
    private var spriteScene: UICharSelection!
    private var scene = CarouselCharSelection()
    weak var chosenCharacter: Character!
    
    override func viewWillAppear(_ animated: Bool) {
        self.sceneView = SCNView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        let backgroundImage = UIImageView(image: UIImage(named: "backgroundImage"))
        self.view.addSubview(backgroundImage)
        //self.sceneView?.addSubview(backgroundImage)
        self.sceneView?.backgroundColor = .clear
        self.sceneView!.scene = scene
        self.sceneView!.delegate = self
        self.spriteScene = UICharSelection(size: self.view.bounds.size)
        spriteScene.uiCharSelectionDelegate = self
        self.sceneView!.overlaySKScene = self.spriteScene
        self.view.addSubview(self.sceneView!)
        SoundTrack.sharedInstance.playInstructions(withName: "escolhaOSeuPersonagem")
    }
    
    func previousCharacter() {
        self.scene.previousPosition()
        let sound = "idle_" + self.scene.centralCharacter.name!
        SoundTrack.sharedInstance.playOno(withName: sound)

    }
    
    func nextCharacter() {
        self.scene.nextPosition()
        let sound = "idle_" + self.scene.centralCharacter.name!
        SoundTrack.sharedInstance.playOno(withName: sound)
    }
    
    func selectCharacter() {
        for character in DAO.sharedInstance.characterArray {
            if character.name == self.scene.centralCharacter.name {
                self.chosenCharacter = character
                DAO.sharedInstance.chosenCharacter = CharacterViewModel(characterModel: chosenCharacter)
            }
        }
        SoundTrack.sharedInstance.stopOno()
        let gameViewController = GameViewController()
        self.navigationController?.pushViewController(gameViewController, animated: true)
    }
    
    func goToMenuScreen() {
        self.navigationController?.popToViewController(ofClass: MenuViewController.self)
    }
    
    func playFirstSound() {
        let sound = "idle_" + self.scene.centralCharacter.name!
        SoundTrack.sharedInstance.playOno(withName: sound)
    }
    
    func printAllNodes(tab:String, node:SKNode) {
        let aTab = tab + "  "
        for child in node.children {
            print(aTab, child.name ?? "--- sem nome ---")
            printAllNodes(tab: aTab, node: child)
            
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        SoundTrack.sharedInstance.stopOno()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.sceneView = nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
