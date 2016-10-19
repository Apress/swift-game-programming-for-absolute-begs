import SpriteKit

class Sparky : AnimatedNode {
    
    var initialY = CGFloat(0)
    var waitTime = CGFloat(0)
    var moveAmount = CGFloat(60)
    var velocity = CGPoint.zero
    
    init(position: CGPoint) {
        super.init()
        self.position = position
        self.initialY = position.y
        
        let anchorPoint = CGPoint(x: 0.5, y: 0.5)
        loadAnimation("spr_sparky_electrocute", looping: false, frameTime: 0.1, name: "electrocute", anchorPoint: anchorPoint)
        loadAnimation("spr_sparky_idle", looping: true, frameTime: 0.5, name: "idle", anchorPoint: anchorPoint)
        playAnimation("idle")
        self.reset()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func reset() {
        waitTime = randomCGFloat() * 5
        self.position.y = initialY
        self.velocity = CGPoint.zero
    }
    
    override func updateDelta(delta: NSTimeInterval) {
        if waitTime <= 0 {
            playAnimation("electrocute")
            position += velocity * CGFloat(delta)
            
            if velocity.y == 0 {
                velocity.y = -200
            }
            if position.y < initialY - moveAmount {
                velocity.y = 30
            }
            if position.y > initialY {
                reset()
            }
        } else {
            playAnimation("idle")
            waitTime -= CGFloat(delta)
        }
        checkPlayerCollision()
    }
    
    func checkPlayerCollision() {
        let player = childNodeWithName("//player") as! Player
        if player.box.intersects(self.box) && self.waitTime <= 0 {
            player.die()
        }
    }
}