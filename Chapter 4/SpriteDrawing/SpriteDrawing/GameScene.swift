import SpriteKit

class GameScene: SKScene {
    
    var balloonSprite = SKSpriteNode(imageNamed: "spr_balloon")
    
    override func didMoveToView(view: SKView) {
        backgroundColor = UIColor.lightGrayColor()
        balloonSprite.position = CGPoint(x: 200, y: 200)
        addChild(balloonSprite)
    }
}