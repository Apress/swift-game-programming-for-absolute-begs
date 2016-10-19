import SpriteKit

class GameScene: SKScene {
    
    var touchingLabel = SKLabelNode(text:"not touching")
    var background = SKSpriteNode(imageNamed: "spr_background")
    var cannonBarrel = SKSpriteNode(imageNamed:"spr_cannon_barrel")
    var touchLocation = CGPoint(x: 0, y: 0)
    var nrTouches = 0
    
    override func didMoveToView(view: SKView) {
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        background.zPosition = 0
        cannonBarrel.zPosition = 1
        touchingLabel.zPosition = 1
        touchingLabel.fontColor = UIColor.blackColor()
        cannonBarrel.position = CGPoint(x:-430, y:-280)
        cannonBarrel.anchorPoint = CGPoint(x:0.233, y:0.5)
        addChild(background)
        addChild(cannonBarrel)
        addChild(touchingLabel)
    }
    
    override func update(currentTime: NSTimeInterval) {
        if nrTouches > 0 {
            touchingLabel.text = "touching"
            let opposite = touchLocation.y - cannonBarrel.position.y
            let adjacent = touchLocation.x - cannonBarrel.position.x
            cannonBarrel.zRotation = atan2(opposite, adjacent)
        } else {
            touchingLabel.text = "not touching"
        }
    }
    
    // Touch input handling
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first!
        touchLocation = touch.locationInNode(self)
        nrTouches = nrTouches + touches.count
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first!
        touchLocation = touch.locationInNode(self)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        nrTouches -= touches.count
    }
}