import SpriteKit

class ThreeColorGameObject {
    var node = SKNode()
    var red = SKSpriteNode()
    var green = SKSpriteNode()
    var blue = SKSpriteNode()
    var velocity = CGPoint.zero
    
    init(_ spriteRed: String, _ spriteGreen: String, _ spriteBlue: String) {
        red = SKSpriteNode(imageNamed: spriteRed)
        green = SKSpriteNode(imageNamed: spriteGreen)
        blue = SKSpriteNode(imageNamed: spriteBlue)
        node.addChild(red)
        node.addChild(green)
        node.addChild(blue)
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
            return node.calculateAccumulatedFrame()
        }
    }
    
    func handleInput(inputHelper: InputHelper) {
    }
    
    func updateDelta(delta: NSTimeInterval) {
        node.position.x += velocity.x * CGFloat(delta)
        node.position.y += velocity.y * CGFloat(delta)
    }
    
    func reset() {
    }
}