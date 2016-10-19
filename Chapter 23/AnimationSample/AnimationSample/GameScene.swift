import SpriteKit

struct Layer {
    static let Background : CGFloat = 0
    static let Background1 : CGFloat = 1
    static let Background2 : CGFloat = 2
    static let Scene : CGFloat = 10
    static let Scene1 : CGFloat = 11
    static let Scene2 : CGFloat = 12
    static let Overlay : CGFloat = 100
    static let Overlay1 : CGFloat = 101
    static let Overlay2 : CGFloat = 102
}

class GameScene: SKScene {
    
    var delta: NSTimeInterval = 1/60
    
    var inputHelper = InputHelper()
    var touchmap: [UITouch:Int] = [UITouch:Int]()
    
    override func didMoveToView(view: SKView) {
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        addChild(GameStateManager.instance)
        //view.frameInterval = 2
        delta = NSTimeInterval(view.frameInterval) / 60
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.backgroundColor = UIColor.grayColor()
        
        GameScreen.instance.size = size
        GameStateManager.instance.add(MainState())
        GameStateManager.instance.switchTo("main")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(currentTime: NSTimeInterval) {
        GameStateManager.instance.handleInput(inputHelper)
        GameStateManager.instance.updateDelta(delta)
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