import SpriteKit

class GameWorld {
    
    var size = CGSize()
    var node = SKNode()
    var background = SKSpriteNode(imageNamed: "spr_background")
    var cannon = Cannon()
    var ball = Ball()
    var can1 = PaintCan(pOffset: -10)
    var can2 = PaintCan(pOffset: 190)
    var can3 = PaintCan(pOffset: 390)
    
    init() {
        background.zPosition = 0
        node.addChild(background)
        node.addChild(cannon.node)
        node.addChild(ball.node)
        node.addChild(can1.node)
        node.addChild(can2.node)
        node.addChild(can3.node)
    }
    
    func handleInput(inputHelper: InputHelper) {
        cannon.handleInput(inputHelper)
        ball.handleInput(inputHelper)
    }
    
    
    func updateDelta(delta: NSTimeInterval) {
        ball.updateDelta(delta)
        can1.updateDelta(delta)
        can2.updateDelta(delta)
        can3.updateDelta(delta)
    }
    
    func isOutsideWorld(pos: CGPoint) -> Bool {
        return pos.x < -size.width/2 || pos.x > size.width/2 || pos.y < -size.height/2
    }
}
