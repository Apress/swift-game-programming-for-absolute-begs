import SpriteKit

class Cannon : ThreeColorGameObject {
    var barrel = SKSpriteNode(imageNamed:"spr_cannon_barrel")
    
    init() {
        super.init("spr_cannon_red", "spr_cannon_green", "spr_cannon_blue")
        red.zPosition = 1
        green.zPosition = 1
        blue.zPosition = 1
        barrel.anchorPoint = CGPoint(x:0.233, y:0.5)
        node.position = CGPoint(x:-430, y:-280)
        node.zPosition = 1
        green.hidden = true
        blue.hidden = true
        node.addChild(barrel)
    }
    
    var ballPosition: CGPoint {
        get {
            let opposite = sin(barrel.zRotation) * barrel.size.width * 0.6
            let adjacent = cos(barrel.zRotation) * barrel.size.width * 0.6
            return CGPoint(x: node.position.x + adjacent, y: node.position.y + opposite)
        }
    }
    
    override func handleInput(inputHelper: InputHelper) {
        if !inputHelper.isTouching {
            return
        }
        let localTouch: CGPoint = GameScene.world.node.convertPoint(inputHelper.touchLocation, toNode: red)
        if !red.frame.contains(localTouch) {
            let opposite = inputHelper.touchLocation.y - node.position.y
            let adjacent = inputHelper.touchLocation.x - node.position.x
            barrel.zRotation = atan2(opposite, adjacent)
        } else if inputHelper.hasTapped {
            let tmp = blue.hidden
            blue.hidden = green.hidden
            green.hidden = red.hidden
            red.hidden = tmp
        }
    }
    
    override func reset() {
        color = UIColor.redColor()
    }
}