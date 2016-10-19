import SpriteKit

class Ball : ThreeColorGameObject {
    var readyToShoot = false
    var shootPaintSound = Sound("snd_shoot_paint")
    
    override init() {
        super.init("spr_ball_red", "spr_ball_green", "spr_ball_blue")
        self.zPosition = 1
        self.hidden = true
    }
    
    convenience init(position: CGPoint) {
        self.init()
        self.position = position
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func handleInput(inputHelper: InputHelper) {
        let localTouch: CGPoint = GameScene.world.convertPoint(inputHelper.touchLocation, toNode: GameScene.world.cannon.red)
        if inputHelper.isTouching && !GameScene.world.cannon.red.frame.contains(localTouch) && self.hidden {
            readyToShoot = true
        }
        if (!inputHelper.isTouching && readyToShoot && self.hidden) {
            self.hidden = false
            readyToShoot = false
            let velocityMultiplier = CGFloat(1.4)
            velocity.x = (inputHelper.touchLocation.x - GameScene.world.cannon.position.x) * velocityMultiplier
            velocity.y = (inputHelper.touchLocation.y - GameScene.world.cannon.position.y) * velocityMultiplier
            shootPaintSound.play()
        }
    }
    
    override func updateDelta(delta: NSTimeInterval) {
        if !self.hidden {
            velocity.x *= 0.99
            velocity.y -= 15
            super.updateDelta(delta)
        } else {
            // calculate the ball position
            self.position = GameScene.world.cannon.ballPosition
            
            // copy the ball color
            self.color = GameScene.world.cannon.color
        }
        if GameScene.world.isOutsideWorld(self.position) {
            reset()
        }
    }
    
    override func reset() {
        self.hidden = true
        readyToShoot = false
    }
    
}