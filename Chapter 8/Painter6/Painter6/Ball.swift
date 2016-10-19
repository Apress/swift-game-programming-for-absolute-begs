import SpriteKit

class Ball {
    var node = SKNode()
    var red = SKSpriteNode(imageNamed: "spr_ball_red")
    var green = SKSpriteNode(imageNamed: "spr_ball_green")
    var blue = SKSpriteNode(imageNamed: "spr_ball_blue")
    var velocity = CGPoint.zero
    var readyToShoot = false
    
    init() {
        node.zPosition = 1
        node.addChild(red)
        node.addChild(green)
        node.addChild(blue)
        node.hidden = true
    }
    
    convenience init(position: CGPoint) {
        self.init()
        node.position = position
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
    
    func handleInput(inputHelper: InputHelper) {
        let localTouch: CGPoint = GameScene.world.node.convertPoint(inputHelper.touchLocation, toNode: GameScene.world.cannon.red)
        if inputHelper.isTouching && !GameScene.world.cannon.red.frame.contains(localTouch) && node.hidden {
            readyToShoot = true
        }
        if (!inputHelper.isTouching && readyToShoot && node.hidden) {
            node.hidden = false
            readyToShoot = false
            let velocityMultiplier = CGFloat(1.4)
            velocity.x = (inputHelper.touchLocation.x - GameScene.world.cannon.node.position.x) * velocityMultiplier
            velocity.y = (inputHelper.touchLocation.y - GameScene.world.cannon.node.position.y) * velocityMultiplier
        }
    }
    
    func updateDelta(delta: NSTimeInterval) {
        if !node.hidden {
            velocity.x *= 0.99
            velocity.y -= 15
            node.position.x += velocity.x * CGFloat(delta)
            node.position.y += velocity.y * CGFloat(delta)
        }
        else {
            // calculate the ball position
            node.position = GameScene.world.cannon.ballPosition
            
            // set the ball color
            red.hidden = GameScene.world.cannon.red.hidden
            green.hidden = GameScene.world.cannon.green.hidden
            blue.hidden = GameScene.world.cannon.blue.hidden
        }
        if GameScene.world.isOutsideWorld(node.position) {
            reset()
        }
    }
    
    func reset() {
        node.hidden = true
        readyToShoot = false
    }
    
}