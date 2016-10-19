import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    override func viewWillLayoutSubviews() {
        
        super.viewWillLayoutSubviews()
        
        let skView = self.view as! SKView
        skView.multipleTouchEnabled = true
        skView.ignoresSiblingOrder = true
        
        var viewSize = skView.bounds.size
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            viewSize.height *= 2
            viewSize.width *= 2
        }
        
        let scene = GameScene(size: viewSize)
        scene.scaleMode = .AspectFill
        skView.presentScene(scene)
        
    }
}