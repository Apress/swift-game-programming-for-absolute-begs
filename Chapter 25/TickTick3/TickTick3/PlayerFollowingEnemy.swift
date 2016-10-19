import SpriteKit

class PlayerFollowingEnemy : PatrollingEnemy {
    
    override func updateDelta(delta: NSTimeInterval) {
        super.updateDelta(delta)
        
        let player = childNodeWithName("//player") as! Player
        let direction = player.position.x - self.position.x
        if direction * velocity.x < 0 && player.velocity != CGPoint.zero {
            self.turnAround()
        }
    }
}