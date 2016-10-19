import SpriteKit

func randomCGFloat() -> CGFloat {
    return CGFloat(arc4random()) / CGFloat(UInt32.max)
}

class PaintCan : ThreeColorGameObject {
    var positionOffset = CGFloat(0)
    var targetColor = UIColor.redColor()
    var minVelocity = CGFloat(40)
    
    init(pOffset: CGFloat, tColor: UIColor) {
        positionOffset = pOffset
        targetColor = tColor
        super.init("spr_can_red", "spr_can_green", "spr_can_blue")
        node.zPosition = 1
        node.hidden = true
    }
    
    override func updateDelta(delta: NSTimeInterval) {
        if node.hidden {
            if randomCGFloat() > 0.01 {
                return
            }
            node.hidden = false
            node.position = CGPoint(x: positionOffset, y: GameScene.world.size.height/2 + red.size.height/2 + 5)
            velocity = CGPoint(x: 0.0, y: randomCGFloat() * -40 - minVelocity)
            let randomval = arc4random_uniform(3)
            red.hidden = randomval != 0
            green.hidden = randomval != 1
            blue.hidden = randomval != 2
        }
        
        super.updateDelta(delta)
        
        let ball = GameScene.world.ball
        if self.box.intersects(ball.box) {
            color = ball.color
            ball.reset()
        }
        
        let top = CGPoint(x: node.position.x, y: node.position.y + red.size.height/2)
        if GameScene.world.isOutsideWorld(top) {
            if color != targetColor {
                GameScene.world.lives -= 1;
            }
            node.hidden = true
        }
        minVelocity += 0.02
    }
    
    override func reset() {
        node.hidden = true
        minVelocity = CGFloat(40)
    }
}