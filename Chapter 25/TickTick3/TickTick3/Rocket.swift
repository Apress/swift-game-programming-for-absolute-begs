import SpriteKit

class Rocket : AnimatedNode {
    
    var startPosition : CGPoint = CGPoint.zero
    var spawnTime : CGFloat = 0
    var velocity = CGPoint.zero
    
    init(moveToLeft: Bool, startPos: CGPoint) {
        startPosition = startPos
        super.init()
        loadAnimation("spr_rocket", looping: true, frameTime: 0.5, name: "default")
        playAnimation("default")
        if moveToLeft {
            self.xScale = -1
        }
        reset()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func reset() {
        self.position = startPosition
        self.velocity = CGPoint.zero
        self.hidden = true
        self.spawnTime = randomCGFloat() * 5
    }
    
    override func updateDelta(delta: NSTimeInterval) {
        super.updateDelta(delta)
        position += velocity * CGFloat(delta)
        if spawnTime > 0 {
            spawnTime -= CGFloat(delta)
            return
        }
        hidden = false
        self.velocity.x = 600
        if self.xScale < 0 {
            self.velocity.x *= -1
        }
        let tileField = childNodeWithName("//tileField") as! TileField
        if !tileField.box.intersects(self.box) {
            self.reset()
        }
    }
}