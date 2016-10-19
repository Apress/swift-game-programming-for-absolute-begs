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
    
    
    override func didMoveToView(view: SKView) {
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        addChild(GameStateManager.instance)
        view.frameInterval = 2
        delta = NSTimeInterval(view.frameInterval) / 60
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        GameScreen.instance.size = size
        
        // create the game states
        GameStateManager.instance.add(TitleMenuState())
        GameStateManager.instance.add(HelpState())
        GameStateManager.instance.add(OptionsMenuState())
        GameStateManager.instance.add(LevelMenuState(nrLevels: 12))
        GameStateManager.instance.switchTo("title")
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
        for touch in touches {
            let location = touch.locationInNode(self)
            touchmap[touch] = inputHelper.touchBegan(location)
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let touchid = touchmap[touch]!
            inputHelper.touchMoved(touchid, loc: touch.locationInNode(self))
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let touchid = touchmap[touch]!
            touchmap[touch] = nil
            inputHelper.touchEnded(touchid)
        }
    }
}
