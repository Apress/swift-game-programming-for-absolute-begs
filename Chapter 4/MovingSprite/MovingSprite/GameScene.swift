import SpriteKit
import AVFoundation

class GameScene: SKScene {
    
    var balloonSprite = SKSpriteNode(imageNamed: "spr_balloon")
    
    override func didMoveToView(view: SKView) {
        backgroundColor = UIColor.lightGrayColor()
        balloonSprite.position = CGPoint(x: 200, y: 200)
        addChild(balloonSprite)
    }
    
    override func update(currentTime: NSTimeInterval) {
        let time = CGFloat(currentTime % 1)
        balloonSprite.position = CGPoint(x: time * size.width, y: 200)
    }

}