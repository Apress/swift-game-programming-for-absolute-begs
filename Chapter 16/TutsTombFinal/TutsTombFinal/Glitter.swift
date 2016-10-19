import SpriteKit

class Glitter : GameObjectNode {
    var sprite = SKSpriteNode()
    
    override init() {
        super.init()
        sprite = SKSpriteNode(imageNamed: "spr_glitter")
        sprite.zPosition = Layer.Scene1
        self.xScale = 0
        self.yScale = 0
        self.addChild(sprite)
        
        // define the action
        let waitAction = SKAction.waitForDuration(0.1, withRange: 0.2)
        let scaleUpAction = SKAction.scaleTo(1, duration: 0.3)
        let scaleDownAction = SKAction.scaleTo(0, duration: 0.3)
        
        let totalAction = SKAction.sequence([waitAction, scaleUpAction, scaleDownAction])
        self.runAction(totalAction, completion: {
            self.removeFromParent()
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
