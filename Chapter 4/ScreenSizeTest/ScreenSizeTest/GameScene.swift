import SpriteKit
import AVFoundation

class GameScene: SKScene {
    
    var backgroundSprite = SKSpriteNode(imageNamed: "spr_screensizes")
    var touchPosLabel = SKLabelNode(text:"(,)")
    
    override func didMoveToView(view: SKView) {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        touchPosLabel.position.y = -200
        addChild(backgroundSprite)
        addChild(touchPosLabel)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first!
        let pos = touch.locationInNode(self)
        touchPosLabel.text = "(\(pos.x), \(pos.y))"
    }
}