import SpriteKit

class ThreeColorGameObject : SKNode {
    var red = SKSpriteNode()
    var green = SKSpriteNode()
    var blue = SKSpriteNode()
    var velocity = CGPoint.zero
    
    override init() {
        super.init()
        self.addChild(red)
        self.addChild(green)
        self.addChild(blue)
    }
    
    init(_ spriteRed: String, _ spriteGreen: String, _ spriteBlue: String) {
        super.init()
        red = SKSpriteNode(imageNamed: spriteRed)
        green = SKSpriteNode(imageNamed: spriteGreen)
        blue = SKSpriteNode(imageNamed: spriteBlue)
        self.addChild(red)
        self.addChild(green)
        self.addChild(blue)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var color: UIColor {
        get {
            if (!red.hidden) {
                return UIColor.redColor()
            } else if (!green.hidden) {
                return UIColor.greenColor()
            } else {
                return UIColor.blueColor()
            }
        }
        set(col) {
            if col != UIColor.redColor() && col != UIColor.greenColor()
                && col != UIColor.blueColor() {
                    return
            }
            red.hidden = col != UIColor.redColor()
            green.hidden = col != UIColor.greenColor()
            blue.hidden = col != UIColor.blueColor()
        }
    }
    
    var box: CGRect {
        get {
            return self.calculateAccumulatedFrame()
        }
    }
    
    func handleInput(inputHelper: InputHelper) {
    }
    
    func updateDelta(delta: NSTimeInterval) {
        self.position.x += velocity.x * CGFloat(delta)
        self.position.y += velocity.y * CGFloat(delta)
    }
    
    func reset() {
    }
}