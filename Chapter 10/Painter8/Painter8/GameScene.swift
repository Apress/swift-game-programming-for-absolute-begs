import SpriteKit

class GameScene: SKScene {
    
    var delta: NSTimeInterval = 1/60
    
    var inputHelper = InputHelper()
    
    static var world = GameWorld()
    
    override init(size: CGSize) {
        super.init(size: size)
        GameScene.world.size = size
        GameScene.world.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func didMoveToView(view: SKView) {
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        addChild(GameScene.world.node)
        
        view.frameInterval = 2
        delta = NSTimeInterval(view.frameInterval) / 60
    }
    
    override func update(currentTime: NSTimeInterval) {
        GameScene.world.handleInput(inputHelper)
        GameScene.world.updateDelta(delta)
        inputHelper.hasTapped = false
    }
    
    // Touch input handling
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first!
        inputHelper.touchLocation = touch.locationInNode(self)
        inputHelper.nrTouches += touches.count
        inputHelper.hasTapped = true
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first!
        inputHelper.touchLocation = touch.locationInNode(self)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        inputHelper.nrTouches -= touches.count
    }
}