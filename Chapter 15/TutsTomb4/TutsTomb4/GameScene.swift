import SpriteKit

struct Layer {
    static let Background : CGFloat = 0
    static let Scene : CGFloat = 1
    static let Scene1 : CGFloat = 2
    static let Scene2 : CGFloat = 3
    static let Overlay : CGFloat = 10
    static let Overlay1 : CGFloat = 11
    static let Overlay2 : CGFloat = 12
}

class GameScene: SKScene {
    
    var delta: NSTimeInterval = 1/60
    
    var inputHelper = InputHelper()
    var touchmap: [UITouch:Int] = [UITouch:Int]()
    
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
        addChild(GameScene.world)
        physicsWorld.contactDelegate = GameScene.world
        view.frameInterval = 2
        delta = NSTimeInterval(view.frameInterval) / 60
    }
    
    override func update(currentTime: NSTimeInterval) {
        GameScene.world.handleInput(inputHelper)
        GameScene.world.updateDelta(delta)
        inputHelper.reset()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for object in touches {
            let touch = object as UITouch
            let location = touch.locationInNode(self)
            touchmap[touch] = inputHelper.touchBegan(location)
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for object in touches {
            let touch = object as UITouch
            let touchid = touchmap[touch]!
            inputHelper.touchMoved(touchid, loc: touch.locationInNode(self))
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for object in touches {
            let touch = object as UITouch
            let touchid = touchmap[touch]!
            touchmap[touch] = nil
            inputHelper.touchEnded(touchid)
        }
    }
}