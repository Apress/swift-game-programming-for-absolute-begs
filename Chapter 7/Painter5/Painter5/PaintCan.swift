import SpriteKit

func randomCGFloat() -> CGFloat {
    return CGFloat(arc4random()) / CGFloat(UInt32.max)
}

class PaintCan {
    
    var node = SKNode()
    var red = SKSpriteNode(imageNamed: "spr_can_red")
    var green = SKSpriteNode(imageNamed: "spr_can_green")
    var blue = SKSpriteNode(imageNamed: "spr_can_blue")
    var velocity = CGPoint.zero
    
    var positionOffset = CGFloat(0)
    var minVelocity = CGFloat(40)
    
    init(pOffset: CGFloat) {
        positionOffset = pOffset
        node.zPosition = 1
        node.addChild(red)
        node.addChild(green)
        node.addChild(blue)
        node.hidden = true
    }
    
    func updateDelta(delta: NSTimeInterval) {
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
        
        node.position.x += velocity.x * CGFloat(delta)
        node.position.y += velocity.y * CGFloat(delta)
        
        let top = CGPoint(x: node.position.x, y: node.position.y + red.size.height/2)
        if GameScene.world.isOutsideWorld(top) {
            node.hidden = true
        }
        minVelocity += 0.02
    }
}