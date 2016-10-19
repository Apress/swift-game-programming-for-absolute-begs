import SpriteKit

class UnpredictableEnemy : PatrollingEnemy {
    
    override func updateDelta(delta: NSTimeInterval) {
        super.updateDelta(delta)
        if waitTime <= 0 && randomCGFloat() < 0.01 {
            self.turnAround()
            self.velocity.x = randomCGFloat() * 300 * xScale
        }
    }
}