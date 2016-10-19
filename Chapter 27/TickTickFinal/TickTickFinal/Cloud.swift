import SpriteKit

class Cloud : SKSpriteNode {
    
    var velocity = CGPoint.zero
    
    init() {
        let cloudSpriteName = "spr_cloud_\(arc4random_uniform(5))"
        let texture = SKTexture(imageNamed: cloudSpriteName)
        super.init(texture: texture, color: UIColor.whiteColor(), size: texture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateDelta(delta: NSTimeInterval) {
        super.updateDelta(delta)
        position += velocity * CGFloat(delta)
        let tileField = childNodeWithName("//tileField") as! TileField
        let minx = -tileField.layout.width / 2 - self.size.width / 2
        let maxx = tileField.layout.width / 2 + self.size.width / 2
        if position.x < minx || position.x > maxx {
            setRandomPositionAndVelocity(true)
        }
    }
    
    func setRandomPositionAndVelocity(placeAtScreenEdge: Bool) {
        let tileField = childNodeWithName("//tileField") as! TileField
        self.position.y = randomCGFloat() * tileField.layout.height - tileField.layout.height / 2
        self.velocity.x = (randomCGFloat() * 2 - 1) * 20
        if !placeAtScreenEdge {
            self.position.x = randomCGFloat() * tileField.layout.width - tileField.layout.width / 2
        } else if self.velocity.x < 0 {
            self.position.x = tileField.layout.width / 2 + self.size.width / 2
        } else {
            self.position.x = -tileField.layout.width / 2 - self.size.width / 2
        }
    }
    
    override func reset() {
        super.reset()
        setRandomPositionAndVelocity(false)
    }
}