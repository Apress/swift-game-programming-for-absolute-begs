import SpriteKit

class PatrollingEnemy : AnimatedNode {
    
    var waitTime : CGFloat = 0
    var velocity = CGPoint(x: 120, y: 0)
    
    //var shapes = SKNode()
    
    override init() {
        super.init()
        loadAnimation("spr_flame", looping: true, frameTime: 0.1, name: "default")
        playAnimation("default")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateDelta(delta: NSTimeInterval) {
        super.updateDelta(delta)
        position += velocity * CGFloat(delta)
        if waitTime > 0 {
            waitTime -= CGFloat(delta)
            if waitTime <= 0 {
                self.turnAround()
            }
        } else {
            let tileField = childNodeWithName("//tileField") as! TileField
            var (col, row) = tileField.layout.toGridLocation(self.position)
            if xScale < 0 {
                col -= 1
            } else {
                col += 1
            }
            if tileField.getTileType(col, row: row - 1) == .Background || tileField.getTileType(col, row: row) == .Wall {
                waitTime = 0.5
                velocity = CGPoint.zero
            }
        }
        checkPlayerCollision()
    }
    
    func checkPlayerCollision() {
        let player = childNodeWithName("//player") as! Player
        if player.box.intersects(self.box) {
            player.die()
        }
    }
    
    func turnAround() {
        xScale = -xScale
        velocity.x = 120 * xScale
    }
}