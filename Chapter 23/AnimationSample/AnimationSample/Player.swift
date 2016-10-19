import SpriteKit

class Player : AnimatedNode {

    var velocity = CGPoint.zero
        
    override init() {
        super.init()
        loadAnimation("spr_player_idle", looping: true, name: "idle")
        loadAnimation("spr_player_run", looping: true, name: "run")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func handleInput(inputHelper: InputHelper) {
        // get the buttons
        let walkLeftButton = childNodeWithName("//button_walkleft") as! Button
        let walkRightButton = childNodeWithName("//button_walkright") as! Button
        
        let walkingSpeed = CGFloat(300)
        if walkLeftButton.down {
            self.velocity.x = -walkingSpeed
        } else if walkRightButton.down {
            self.velocity.x = walkingSpeed
        } else {
            self.velocity.x = 0
        }
        if self.velocity.x < 0 {
            self.xScale = -1
        } else if self.velocity.x > 0 {
            self.xScale = 1
        }
    }
    
    override func updateDelta(delta: NSTimeInterval) {
        super.updateDelta(delta)
        position += velocity * CGFloat(delta)
    
        if self.velocity.x == 0 {
            self.playAnimation("idle")
        } else {
            self.playAnimation("run")
        }
    }
}