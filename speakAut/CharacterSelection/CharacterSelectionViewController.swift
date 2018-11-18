import UIKit
import SceneKit
import SpriteKit

class CharSelectionViewController: UIViewController {
    
    var sceneView: SCNView!
    var spriteScene: UICharSelection!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        
        self.sceneView = SCNView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        self.sceneView.scene = CarousselCharSelection()
        
        self.spriteScene = UICharSelection(size: self.view.bounds.size)
        self.sceneView.overlaySKScene = self.spriteScene
        
        self.view.addSubview(self.sceneView)
        
        printAllNodes(tab: "", node: self.spriteScene)
    
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

