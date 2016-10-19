import SpriteKit

class WaterDrop : SKSpriteNode {
    
    var bounce: CGFloat = 0
    var totalTime: CGFloat = 0
    
    init() {
        let texture = SKTexture(imageNamed: "spr_water")
        super.init(texture: texture, color: UIColor.whiteColor(), size: texture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateDelta(delta: NSTimeInterval) {
        super.updateDelta(delta)
        totalTime += CGFloat(delta)
        position.y += self.bounce
        let t = totalTime + position.x
        self.bounce = sin(t*5) * 5
        position.y -= self.bounce
    }
    
    override func reset() {
        super.reset()
        self.hidden = false
    }
}