import SpriteKit
import AVFoundation

class GameScene: SKScene {
    
    var backgroundSprite = SKSpriteNode(imageNamed: "spr_background")
    var balloonSprite = SKSpriteNode(imageNamed: "spr_balloon")
    
    override func didMoveToView(view: SKView) {
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        backgroundSprite.zPosition = 0
        balloonSprite.zPosition = 1
        addChild(backgroundSprite)
        addChild(balloonSprite)
    }
    
    override func update(currentTime: NSTimeInterval) {
        let time = CGFloat(currentTime % 1)
        balloonSprite.position = CGPoint(x: time * size.width - size.width/2, y: 200)
    }
    
}