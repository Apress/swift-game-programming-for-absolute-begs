import SpriteKit

class GameScene: SKScene {
    
    override func didMoveToView(view: SKView) {
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "Hello, World!"
        myLabel.fontSize = 65
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        addChild(myLabel)
    }
    
    override func update(currentTime: NSTimeInterval) {
        backgroundColor = UIColor.blueColor()
    }
}