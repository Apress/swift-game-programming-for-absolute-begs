import SpriteKit

class Ball : ThreeColorGameObject {
    var readyToShoot = false
    
    init() {
        super.init("spr_ball_red", "spr_ball_green", "spr_ball_blue")
        node.zPosition = 1
        node.hidden = true
    }
    
    convenience init(position: CGPoint) {
        self.init()
        node.position = position
    }
    
    override func handleInput(inputHelper: InputHelper) {
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
    
    override func updateDelta(delta: NSTimeInterval) {
        if !node.hidden {
            velocity.x *= 0.99
            velocity.y -= 15
            super.updateDelta(delta)
        } else {
            // calculate the ball position
            node.position = GameScene.world.cannon.ballPosition
            
            // copy the ball color
            self.color = GameScene.world.cannon.color
        }
        if GameScene.world.isOutsideWorld(node.position) {
            reset()
        }
    }
    
    override func reset() {
        node.hidden = true
        readyToShoot = false
    }
    
}