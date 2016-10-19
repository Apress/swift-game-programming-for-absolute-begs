import SpriteKit

class GameWorld {
    
    var size = CGSize()
    var node = SKNode()
    var background = SKSpriteNode(imageNamed: "spr_background")
    var cannon = Cannon()
    var ball = Ball()
    var can1 = PaintCan(positionOffset: -10, targetColor: UIColor.redColor())
    var can2 = PaintCan(positionOffset: 190, targetColor: UIColor.greenColor())
    var can3 = PaintCan(positionOffset: 390, targetColor: UIColor.blueColor())
    var lives = 5
    var livesNode = SKNode()
    var gameover = SKSpriteNode(imageNamed: "spr_gameover")
    
    func setup() {
        background.zPosition = 0
        node.addChild(background)
        node.addChild(cannon.node)
        node.addChild(ball.node)
        node.addChild(can1.node)
        node.addChild(can2.node)
        node.addChild(can3.node)
        livesNode.position.x = -size.width/2 + 35
        livesNode.position.y = size.height/2 - 120
        node.addChild(livesNode)
        for index in 0..<lives {
            let livesSpr = SKSpriteNode(imageNamed: "spr_lives")
            livesSpr.position = CGPoint(x: index * Int(livesSpr.size.width), y: 0)
            livesNode.addChild(livesSpr)
        }
        node.addChild(gameover)
        gameover.zPosition = 2
        gameover.hidden = true
    }
    
    func handleInput(inputHelper: InputHelper) {
        if (lives > 0) {
            cannon.handleInput(inputHelper)
            ball.handleInput(inputHelper)
        } else if (inputHelper.hasTapped) {
            reset()
        }
    }
    
    func updateDelta(delta: NSTimeInterval) {
        gameover.hidden = lives > 0
        if (lives <= 0) {
            return
        }
        ball.updateDelta(delta)
        can1.updateDelta(delta)
        can2.updateDelta(delta)
        can3.updateDelta(delta)
        for index in 0..<livesNode.children.count {
            let livesSpr = livesNode.children[index] as SKNode
            livesSpr.hidden = lives <= index
        }
    }
    
    func reset() {
        lives = 5
        cannon.reset()
        ball.reset()
        can1.reset()
        can2.reset()
        can3.reset()
    }
    
    func isOutsideWorld(pos: CGPoint) -> Bool {
        return pos.x < -size.width/2 || pos.x > size.width/2 || pos.y < -size.height/2
    }
}