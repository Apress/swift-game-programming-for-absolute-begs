import SpriteKit

class Turtle : AnimatedNode {
    
    var waitTime : CGFloat = 0
    var sneezing = false
    
    override init() {
        super.init()
        let anchorPoint = CGPoint(x: 0.5, y: 0.5)
        loadAnimation("spr_turtle_sneeze", looping: false, frameTime: 0.5, name: "sneeze", anchorPoint: anchorPoint)
        loadAnimation("spr_turtle_idle", looping: true, frameTime: 0.5, name: "idle", anchorPoint: anchorPoint)
        playAnimation("idle")
        reset()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func reset() {
        self.sneezing = false
        self.waitTime = 5
    }
    
    override func updateDelta(delta: NSTimeInterval) {
        super.updateDelta(delta)
        if sneezing {
            self.playAnimation("sneeze")
        } else {
            self.playAnimation("idle")
        }
        if waitTime > 0 {
            waitTime -= CGFloat(delta)
        } else {
            sneezing = !sneezing
            waitTime = 5
        }
        checkPlayerCollision()
    }
    
    func checkPlayerCollision() {
        let player = childNodeWithName("//player") as! Player
        if !player.box.intersects(self.box) {
            return
        }
        if sneezing {
            player.die()
        } else if player.velocity.y < 0 && player.alive {
            player.jump(900)
        }
    }
}